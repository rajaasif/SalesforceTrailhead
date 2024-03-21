public class AccountTriggerHandler {
    public static void beforeupdatetriggerhandler(List<Account> newrecords,Map<id,Account> oldMap){
        for(Account acc: newrecords){
            if(acc.Industry=='Agriculture' && acc.Type=='Prospect'){
                if(oldMap.get(acc.Id).Ownership != acc.Ownership && acc.Ownership=='Private'){
                    acc.addError('You cannot set you ownership to private');
                } 
            }
        } 
    }
    public static void afterupdatetriggerhandler(List<Account> newrecords,Map<id,Account> oldMap){
        Map<id,String> acc_map=new Map<id,String>();
        for(Account acc: newrecords){
            if(oldMap.get(acc.Id).Website != acc.Website){
                acc_map.put(acc.Id,acc.Website);
            }
        }
        if(acc_map.keySet().size()>0){
            List<Contact> cont_toupdate=new List<Contact>();
            List<Contact> contact_list=[SELECT id,FirstName,Website__c,AccountId FROM Contact WHERE AccountId IN:acc_map.keySet()];
            for(Contact cont: contact_list){
                cont.Website__c=acc_map.get(cont.AccountId);
                cont_toupdate.add(cont);
            }
            update cont_toupdate;
        }
    }
    public static void afterinserttriggerhandler(List<Account> newrecords){
        List<Contact> contacts_inserted=new List<Contact>();
        for(Account acc: newrecords){
            if(acc.create_N_contacts__c != null){
                for(integer i=0;i<acc.create_N_contacts__c;i++){
                    Contact con=new Contact();
                    con.AccountId=acc.Id;
                    con.FirstName=acc.Name;
                    con.LastName='abc'+i;
                    contacts_inserted.add(con);
                }
            }
        }
        insert contacts_inserted;
    }
    public static void beforedeletetriggerhandler(List<Account> oldrecords){
        Map<Id,Account> accwithopps = new Map<Id,Account>([SELECT Id,(SELECT Id FROM Opportunities) FROM Account WHERE Id IN :oldrecords]);
        for(Account acc: oldrecords){
            if(accwithopps.get(acc.Id).Opportunities.size() != 0){
                acc.addError('Cannot delete this account');
            }
        }
    }
    public static void matchbillingAddress(List<Account> newrecords, Map<Id,Account> oldmap){
        
        if(Trigger.isInsert){
            for(Account acc: newrecords){
                if(acc.Match_Billing_Address__c==true){
                	acc.ShippingPostalCode= acc.BillingPostalCode;
                }
            }
        }else if (Trigger.isUpdate){
            for(Account acc: newrecords){
                if(acc.Match_Billing_Address__c==true){
                    acc.ShippingPostalCode= acc.BillingPostalCode;
                }
            }            
        }
    }
    
}