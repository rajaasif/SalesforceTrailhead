public class LeadProcessor implements Database.Batchable<sObject>, Database.Stateful {
    Integer recordsProcessed=0;
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, LeadSource FROM Lead');
    }

    public void execute(Database.BatchableContext bc, List<Lead> scope) {
        List<Lead> leads=new List<Lead>();
        for(Lead lead: scope){
            lead.LeadSource='Dreamforce';
            leads.add(lead);
            recordsProcessed++;
        }

        update leads;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors,
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }
}