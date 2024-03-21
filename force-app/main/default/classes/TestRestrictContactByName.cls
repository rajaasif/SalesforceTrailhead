@isTest
public class TestRestrictContactByName {
    @isTest static void testcontacttrigger(){
        Contact con=new Contact(
            FirstName='Test',
            LastName='INVALIDNAME'
        );
        Test.startTest();
        Database.SaveResult result=DataBase.insert(con,false);
        Test.stopTest();
        System.assertEquals('The Last Name "'+con.LastName+'" is not allowed for DML',result.getErrors()[0].getMessage());
    }  
}