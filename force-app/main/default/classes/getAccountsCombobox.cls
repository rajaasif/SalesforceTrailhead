public class getAccountsCombobox {
    @AuraEnabled
    public static List<Account> getAccounts() {
        return [select Id, Name from Account];
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactDetail(String accountID) {
        return [select Id, Name,Email,AccountId from Contact where AccountId = :accountID];
    }
}