public class Soql_queries {
    public static void soql(){
        List<Contact> cont=[SELECT FirstName,LastName FROM Contact WHERE FirstName='Raja' AND LastName='Asif' LIMIT 1];
        Account acc=[SELECT Account.Name FROM Account WHERE Account.Name='Dickenson plc'];
        ID acc_id= acc.Id;
        if(cont.isEmpty()){
            System.debug('This contact does not exist so we will create this contactfor you');
            Contact new_cont=new Contact(FirstName='Raja',LastName='Asif',Department='New Department', AccountId=acc_id);
            try{
                insert new_cont;
                System.debug('Created this contact');
            }
            catch(DMLException e){
                System.debug('Following error occureed: '+ e.getMessage());
            }
        }
    }
    public static void assign_deps(){
        List<Contact> departments=[SELECT Department FROM Contact];
        for(Contact deps: departments){
            if(String.isBlank(deps.Department)){
                deps.Department='Assigned New Dept';
                update departments;
            }
        }
    }
}