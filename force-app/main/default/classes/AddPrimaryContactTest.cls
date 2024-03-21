@isTest
public class AddPrimaryContactTest {
    @isTest static void testSetup(){
        List<Account> accountWithNY=new List<Account>();
        List<Account> accountWithCA=new List<Account>();
        for(Integer i=0;i<50;i++){
            Account newAccount=new Account();
            newAccount.Name='Test Account '+i;
            newAccount.BillingState='NY';
            accountWithNY.add(newAccount);
        }
        try{
            insert accountWithNY;
        }
        catch(DMLException e){
            System.debug('Following error occured: '+ e.getMessage());
        }
        
        for(Integer i=0;i<50;i++){
            Account newAccount=new Account();
            newAccount.Name='Test Account '+i;
            newAccount.BillingState='CA';
            accountWithCA.add(newAccount);
        }
        insert accountWithCA;
        Contact contact=new Contact(
            FirstName='Test',
            LastNAme='Contact'
        );
        insert contact;
        Test.startTest();
        	System.enqueueJob(new AddPrimaryContact(contact,'CA'));
        Test.stopTest();
    }  
}