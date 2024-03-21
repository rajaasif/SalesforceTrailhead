public class ContactTriggerHandler {
    public static void beforeinsertContactHandler(List<Contact> newContacts){
        							//	
        List<Contact> con_list=[SELECT Id, LastName, Email, Phone FROM Contact];
        //System.debug(con_list);
        for(Contact con: newContacts){
            for(Contact existingcon: con_list){
               // con.AccountId==null || 
                if(con.LastName == existingcon.LastName || con.Email==existingcon.Email){
                con.addError('Account ID is  or duplicate fields.');
            	}
            }  
        }
        							//
        List<Id> acc_ids=new List<Id>();
        Map<Id,Id> conVsacc=new Map<Id,Id>();
        for(Contact con: newContacts){
            acc_ids.add(con.AccountId);
            conVsacc.put(con.Id,con.AccountId);
        }
        Map<Id,Account> accvsaddress=new Map<Id,Account>([SELECT Id, Max_Contacts_Allowed__c, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, BillingLatitude, BillingLongitude, BillingGeocodeAccuracy,(select id from contacts) FROM Account WHERE Id IN :acc_ids]);
        
        for(Id accId: accvsaddress.keySet()){
            Integer max_contact_count=Integer.ValueOf(accvsaddress.get(accId).Max_Contacts_Allowed__c);
            Integer number_of_contacts_assigned=(accvsaddress.get(accId).contacts).size(); 
            //System.debug('number of contact :  '+number_of_contacts_assigned);
        	//System.debug('number of contact ALLOWED:  '+ max_contact_count);
            if(number_of_contacts_assigned >= max_contact_count){
                for(Contact con: newContacts){
                    if(con.AccountId == accId){
                        con.addError('Contact limit reached for this account');
                    }
                }
            }
        }
        
        for(Contact con: newContacts){
            if(accvsaddress.containsKey(con.AccountId)){
                con.MailingStreet=accvsaddress.get(con.AccountId).BillingStreet;
                con.MailingCity=accvsaddress.get(con.AccountId).BillingCity;
                con.MailingState=accvsaddress.get(con.AccountId).BillingState;
                con.MailingPostalCode=accvsaddress.get(con.AccountId).BillingPostalCode;
                con.MailingCountry=accvsaddress.get(con.AccountId).BillingCountry;
                con.MailingLatitude=accvsaddress.get(con.AccountId).BillingLatitude;
                con.MailingLongitude=accvsaddress.get(con.AccountId).BillingLongitude;
                con.MailingGeocodeAccuracy=accvsaddress.get(con.AccountId).BillingGeocodeAccuracy;
            }
        }
    }
    
    
    
    public static void afterinsertContactHandler(List<Contact> newContacts){
        List<ContactShare> contact_share=new List<ContactShare>();
        ID sharegroup_id=[SELECT Id, Name FROM Group WHERE Name='Contact Innovators' LIMIT 1].id;
        for(Contact con: newContacts){
            ContactShare conS=new ContactShare();
            conS.RowCause='Manual';
            conS.ContactId=con.Id;
            conS.UserOrGroupId=sharegroup_id;
            conS.ContactAccessLevel='Edit';
            contact_share.add(conS);
        }
        if(!contact_share.isEmpty()){
            try{
                insert contact_share;
            }
            catch(DMLException e){
                System.debug('Following error occurred: '+ e.getMessage());
            }
            
        }
    }
    public static void sendmailContactHandler(List<Contact> newContacts,Map<Id,Contact> oldrecords){
        List<Id> account_ids=new List<Id>();
        for(Contact con: newContacts){
            if(con.AccountId != null){
                if(con.Email != oldrecords.get(con.Id).Email || con.Phone != oldrecords.get(con.Id).Phone){
                	account_ids.add(con.AccountId);
            	}
            }
        }
        //List<String> email_addresses=new List<String>();
        Map<Id,String> email_addresses=new Map<Id,String>();
        List<Account> accvsowner=[SELECT OwnerId,Owner.Email FROM Account WHERE Id IN :account_ids];
        for(Account acc: accvsowner){
            email_addresses.put(acc.Id,acc.Owner.Email);
        }
        for(Id accid: account_ids){
            String subject='Email or Phone changed';
            String body='Email or phone for your contact is modified';
            EmailMissionSpecialist.sendMail(email_addresses.get(accid),subject,body);
        } 
    }
    public static void createNlocations(List<Contact> newContacts,Map<Id,Contact> oldmap){
        List<MyLocation__c> my_locations=new List<MyLocation__c>();
        Map<Id,MyLocation__c> existing_locations;
        if(oldmap != null){
            existing_locations =new Map<Id,MyLocation__c>([SELECT Id,Contact__c FROM MyLocation__c WHERE  Contact__c IN :oldmap.keySet()]);
        }
        
        List<MyLocation__c> locs_to_delete=new List<MyLocation__c>();
        for(Contact con: newContacts){
            if(Trigger.isInsert){
                Integer number_of_locations= Integer.valueOf(con.Create_N_Locations__c);
                for(Integer i=0;i<number_of_locations;i++){
                    MyLocation__c loc=new MyLocation__c();
                    loc.Contact__c=con.Id;
                    loc.Name=con.FirstName+' \'s location'+ i;
                    my_locations.add(loc);
                }
            }
            else if(Trigger.isUpdate){ 
                List<Id> contact_ids=new List<Id>();
                if(con.Create_N_Locations__c != oldmap.get(con.Id).Create_N_Locations__c){
                    if(con.Create_N_Locations__c > oldmap.get(con.Id).Create_N_Locations__c){
                        Integer differnce=Integer.valueOf(con.Create_N_Locations__c - oldmap.get(con.Id).Create_N_Locations__c);
                        for(Integer i=0;i<differnce;i++){
                    		MyLocation__c loc=new MyLocation__c();
                    		loc.Contact__c=con.Id;
                    		loc.Name=con.FirstName+' \'s location'+ i;
                    		my_locations.add(loc);
                            System.debug('Added new: '+i);
                    }
                }
                    else if(con.Create_N_Locations__c < oldmap.get(con.Id).Create_N_Locations__c){
                        Integer diff=Integer.valueOf(oldmap.get(con.Id).Create_N_Locations__c - con.Create_N_Locations__c);
                            for(MyLocation__c loc: existing_locations.values()){
                            	if(loc.Contact__c == con.Id){
                                    if(locs_to_delete.size() < diff){
                                        locs_to_delete.add(loc);
                                        System.debug(locs_to_delete);
                                    }
                                	
                            	}
                        	} 
                }
        	}
                
        }
    }
        if(!my_locations.isEmpty()){
                insert my_locations;
            }
        if(!locs_to_delete.isEmpty()){
            delete locs_to_delete;
        }
}
}