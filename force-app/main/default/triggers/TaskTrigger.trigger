trigger TaskTrigger on Task (before insert,after insert,before update) {
    if(Trigger.isInsert && Trigger.isBefore){
    }
    if(Trigger.isInsert && Trigger.isAfter){
        TaskTrigger.afterinsertHandler(Trigger.NEW);
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            TaskTrigger.beforeupdatehandler(Trigger.NEW);
        }
    }
}