public class AccountProcessor {
	@future
    public static void countContacts(List<Id> acc_ids){
        Map<Id,Account> accwithcon=new Map<Id,Account>([SELECT Id, Number_Of_Contacts__c,(select Id from Contacts)FROM Account WHERE Id IN :acc_ids]);
        List<Account> acctoupdate=new List<Account>();
        for(Account acct: accwithcon.values()){
                acct.Number_Of_Contacts__c=acct.Contacts.size();
            	acctoupdate.add(acct);
        }
        update acctoupdate;
        
    }
}