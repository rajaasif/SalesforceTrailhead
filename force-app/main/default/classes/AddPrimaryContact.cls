public class AddPrimaryContact implements Queueable {
    Contact contact;
    private String state;
    public AddPrimaryContact(Contact contact, String state){
        this.contact=contact;
        this.state= state;
    }
    public void execute(QueueableContext context){
        List<Account> accounts=[SELECT Id,BillingState FROM Account WHERE BillingState= :state LIMIT 200];
        List<Contact> contactsToInsert=new List<Contact>();
        for(Account acc: accounts){
            Contact newContact=contact.clone(false,false,false,false);
            newContact.AccountId=acc.Id;
            contactsToInsert.add(newContact);
            
        }
        insert contactsToInsert;
    }

}