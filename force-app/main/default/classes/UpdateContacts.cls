public class UpdateContacts implements Database.Batchable<SObject>, Database.AllowsCallouts {
    public Database.QueryLocator  start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id FROM Contact WHERE MailingPostalCode != null');

    }
    public void execute(Database.BatchableContext context, List<Contact> contactList){
        
        HttpRequest req=new HttpRequest();
        String endpoint='https://www.zipcodeapi.com/rest/DemoOnly008wrXjok3IFAKxC1kZLOB9AGVkCRwreLQXnmQY1Uc8CdstCMClc1rZl/multi-info.json/10001%2C10002/degrees';
        req.setEndpoint(endpoint);
        req.setMethod('GET');

    }
    public void finish(Database.BatchableContext bc){
        
    }
}