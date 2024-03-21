// DailyLeadProcessorTest class
@isTest
public class DailyLeadProcessorTest {
    @isTest
    static void testLeadProcessor() {
        // Insert 200 Lead records with blank LeadSource field
        List<Lead> testLeads = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            testLeads.add(new Lead(LastName = 'TestLead' + i,Company='abc'));
        }
        insert testLeads;

        // Schedule the DailyLeadProcessor class
        Test.startTest();
        String jobId = System.schedule('Test Job', '0 0 0 * * ?', new DailyLeadProcessor());
        Test.stopTest();

        // Verify that all Lead records were updated correctly
        List<Lead> updatedLeads = [SELECT Id, LeadSource FROM Lead WHERE Id IN :testLeads];
        for (Lead lead : updatedLeads) {
            System.assertEquals('Dreamforce', lead.LeadSource, 'LeadSource should be updated to Dreamforce');
        }
    }
}