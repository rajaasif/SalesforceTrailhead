@istest
public class LeadProcessorTest {
    @istest static void leadtest(){
        List<Lead> leadsToInsert = new List<Lead>();

        for(Integer i = 0; i < 200; i++) {
            Lead lead = new Lead();
            lead.FirstName = 'Lead ' + i;
            lead.LastName='lname '+i;
            lead.Company='abc company';
            // Set other lead attributes as needed
            leadsToInsert.add(lead);
        }

        insert leadsToInsert;

        Test.startTest();
        	LeadProcessor lp=new LeadProcessor();
        	Id batchid=Database.executeBatch(lp);
        Test.stopTest();
        
        
    }
}