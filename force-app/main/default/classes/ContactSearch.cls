public class ContactSearch {
    public static List<Contact> searchForContacts(String last_name, String mailingpostalcode){
        List<Contact> cont=[SELECT FirstName,LastName FROM Contact WHERE LastName=:last_name AND MailingPostalCode=:mailingpostalcode];
        return cont;
    }
}