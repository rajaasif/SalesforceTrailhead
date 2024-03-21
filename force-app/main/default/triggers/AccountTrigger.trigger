trigger AccountTrigger on Account (before insert,before update,after update,after insert,before delete) {
   
    if(Trigger.isUpdate && Trigger.isBefore){
        AccountTriggerHandler.beforeupdatetriggerhandler(Trigger.NEW,Trigger.oldmap);
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        AccountTriggerHandler.afterupdatetriggerhandler(Trigger.NEW,Trigger.oldmap); 
    }
    if(Trigger.isInsert && Trigger.isAfter){
        AccountTriggerHandler.afterinserttriggerhandler(Trigger.NEW); 
    }
    if(Trigger.isDelete && Trigger.isBefore){
        AccountTriggerHandler.beforedeletetriggerhandler(Trigger.OLD); 
    }
}