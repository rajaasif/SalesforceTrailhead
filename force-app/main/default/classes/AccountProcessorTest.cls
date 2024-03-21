@isTest
public class AccountProcessorTest {
  @isTest static void testAccount(){
      Account acc=new account(Name='Future Test Account');
      insert acc;
      Contact con=new Contact();
      con.FirstName='abcd';
      con.LastName='defg';
      con.AccountId=acc.Id;
      insert con;
      List<Id> acct=new List<Id>();
      acct.add(acc.Id);
      Test.startTest();
		AccountProcessor.countContacts(acct);
      Test.stopTest();
      Account accountsss = [select Number_of_Contacts__c from Account where id = :acc.id LIMIT 1];
        System.assertEquals ( Integer.valueOf(accountsss.Number_of_Contacts__c) ,1);
    }
}