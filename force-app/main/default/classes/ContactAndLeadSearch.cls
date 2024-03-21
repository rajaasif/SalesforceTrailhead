public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String search_query){
        List<List<sObject>> searchlist=[FIND :search_query IN ALL FIELDS RETURNING Contact(FirstName,LastName),Lead(FirstName,LastName)];
        return searchlist;
    }
}