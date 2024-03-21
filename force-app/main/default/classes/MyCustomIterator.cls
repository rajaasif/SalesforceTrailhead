public class MyCustomIterator implements Iterator<Account> {
    private List<Account> account;
    private Integer index;
    public MyCustomIterator(List<Account> account){
        this.account=account;
        this.index=0;
    }
    public Boolean hasNext(){
        return index < account.size();
    }
    public Account next(){
        if(hasNext()){
            return account[index++];
        }
        else {
           throw new NoSuchElementException('Iterator has no more elements.');
       }
    }
}