public class Update_related_fields {
    public static void update_r_fields(){
        Contact cont=[SELECT Account.Name FROM Contact WHERE FirstName='Avi' AND LastName='Green' LIMIT 1];
    	cont.Phone='222-222-222';
        cont.Account.Name='Industry is updated';
        update cont;
        update cont.Account;
    }
    

}