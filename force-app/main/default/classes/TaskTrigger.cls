public class TaskTrigger {
    public static void afterinsertHandler(List<Task> newrecords){
        //if two records are inserted for the same contact,  list will store duplicate values so i will use Set instead of list
        //but now contact_ids will only store 1 id instead of 2 and the secod loop witll iterate only once so we need to keep track of count
        Map<Id,Integer> count=new Map<Id,Integer>();
        // but now map contains contact ids so ne need to store ids in separate Set
        //Set<Id> contacts_ids=new Set<Id>();
        for(Task task: newrecords){
            //because contact ids always start with '003'
            System.debug(String.ValueOf(task.WhoId));
            if(String.ValueOf(task.WhoId).StartsWith('003')){
                //contacts_ids.add(task.WhoId);
                if(count.containsKey(task.WhoId)){
                    Integer countvar=count.get(task.WhoId)+1;
                    count.put(task.WhoId,countvar);
                }
                else{
                       count.put(task.WhoId,1);
                   }  
                }
        }
        List<Contact> conlist=[SELECT Id,Number_of_Tasks_associated__c FROM Contact WHERE Id IN :count.keySet()];
        List<Contact> update_con=new List<Contact>();
        for(Contact con: conlist){
            if(con.Number_of_Tasks_associated__c  != null){
                con.Number_of_Tasks_associated__c += count.get(con.Id) ;
                System.debug(con.Number_of_Tasks_associated__c);
            }
            else {
                con.Number_of_Tasks_associated__c =count.get(con.Id);
                System.debug(con.Number_of_Tasks_associated__c);
            }
            update_con.add(con);
        }
        update update_con;
    }
    public static void beforeupdatehandler(List<Task> newrecords){
        List<Id> contact_ids=new List<Id>();
        Map<Id,Id> taskVscon=new Map<Id,Id>();
        for(Task task: newrecords){
            //to check if whoidis a lead or a contact and to check this we know contacts have 003 at the start or ids
            if(String.ValueOf(task.WhoId).StartsWith('003')){
                contact_ids.add(task.WhoId);
                taskVscon.put(task.Id,task.WhoId);
            } 
        }
        Map<Id,Account> accounts=new Map<Id,Account>([SELECT Id,Update_Permission__c FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Id IN :contact_ids)]);
        Map<Id,Id> conVsacc=new Map<Id,Id>();
        List<Contact> conrecords=[SELECT AccountId FROM Contact WHERE Id IN :contact_ids];
        for(Contact con: conrecords){
            conVsacc.put(con.Id,con.AccountId);
        }
        for(Task task: newrecords){
            if(!accounts.get(conVsacc.get(taskVscon.get(task.Id))).Update_Permission__c){
                task.addError('You are not allowed to update the task');
            }
        }  
    }
    
}