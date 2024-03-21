public class getContactDetailsforWireDemo {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getConList() {
        List<Contact> contacts = new List<Contact>();
        try {
            contacts = [SELECT Id, FirstName FROM Contact];
        } catch(Exception e) {
            System.debug('Error occurred while fetching contacts: ' + e.getMessage());
        }
        return contacts;
    }
}
