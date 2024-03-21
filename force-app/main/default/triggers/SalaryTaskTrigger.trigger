trigger SalaryTaskTrigger on Salary__c (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            SalaryTaskHandler.beforeinserthandler(Trigger.new);
        }
    }
}