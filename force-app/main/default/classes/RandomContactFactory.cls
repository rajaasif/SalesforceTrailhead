public class RandomContactFactory {
    public static List<Contact> generateRandomContacts (Integer numOfcontacts, String last_name){
        List<Contact> con=new List<Contact>();
        for(Integer i=0;i<numOfcontacts;i++){
            con.add(new Contact(FirstName='Test '+i,LastName=last_name +' '+i));
        }
        return con;
    }
    
}