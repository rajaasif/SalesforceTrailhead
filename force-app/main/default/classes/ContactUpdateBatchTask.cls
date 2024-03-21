public class ContactUpdateBatchTask implements Database.Batchable<sObject> , Database.AllowsCallouts {
    public ContactUpdateBatchTask() {

    }
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT Id,MailingPostalCode FROM Contact WHERE MailingPostalCode != null');
    }
    public void execute(Database.BatchableContext context, List<Contact> contactList){
        List<String> postalCodes=new List<String>();
        // 10001,10002,10003
        for(Contact conList: contactList){
            postalCodes.add(conList.MailingPostalCode);
        }
        String codesString = String.join(postalCodes, ',');
        Http http = new Http();
        HttpRequest req=new HttpRequest();
        String endpoint='https://www.zipcodeapi.com/rest/DemoOnly008wrXjok3IFAKxC1kZLOB9AGVkCRwreLQXnmQY1Uc8CdstCMClc1rZl/multi-info.json/'+codesString+'/degrees';
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        HttpResponse res=http.send(req);
        List<Contact> conListToUpdate=new List<Contact>();
        if(res.getStatusCode() == 200){
            // System.debug(ZipCodes.parse(res.getBody()).get('10001').city);
            for(Contact con: contactList){
                con.MailingCity = ZipCodes.parse(res.getBody()).get(con.MailingPostalCode).city;
                con.MailingState = ZipCodes.parse(res.getBody()).get(con.MailingPostalCode).state;
                con.MailingLatitude = ZipCodes.parse(res.getBody()).get(con.MailingPostalCode).lat;
                con.MailingLongitude = ZipCodes.parse(res.getBody()).get(con.MailingPostalCode).lng;
                conListToUpdate.add(con);
            }
        }
        else {
            System.debug('');
        }
        try {
            update conListToUpdate;
        }
        catch (DmlException e){
            System.debug('Following error occured: '+ e.getMessage());
        }
        

    }
    public void finish(Database.BatchableContext bc){
        
    }
}