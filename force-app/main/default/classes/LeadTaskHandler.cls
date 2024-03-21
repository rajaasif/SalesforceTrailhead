public class LeadTaskHandler {
    public static void leadtaskhandler(List<Lead> newRecords){
        List<Task> taskToBeCreated = new List<Task>();
        for(Lead lead: newRecords){
            Task task=new Task();
            task.WhoId=lead.Id;
            task.OwnerId=lead.OwnerId;
            task.Status='Not Started';
            task.Subject='Follow up';
            task.Description='PLease follow up with the customer';
            task.Priority='High';
            taskToBeCreated.add(task);
        }
        if(!taskToBeCreated.isEmpty()){
            insert taskToBeCreated;
            System.debug('Task created ');
        }
    }
    public static void beforedeletehandler(List<Lead> oldrecords){
        for(Lead lead: oldrecords){
            if(lead.Status=='Working - Contacted'){
                lead.addError('This record cannot be deleted');
            }
        }
    }

}