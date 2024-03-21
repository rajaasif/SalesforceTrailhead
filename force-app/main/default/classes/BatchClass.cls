public class BatchClass implements Database.Batchable<Account> {
    public Iterable<Account> start(Database.BatchableContext bc){
        return new CustomIterable();
    }
    public void execute(Database.BatchableContext bc , List<Account> records){
        
    }
    public void finish(Database.BatchableContext bc){
        
    }

}