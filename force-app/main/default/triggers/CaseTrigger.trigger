trigger CaseTrigger on Case (before insert,before delete) {
    if(Trigger.isInsert && Trigger.isBefore){
        CaseTriggerHandler.beforeinserthandler(Trigger.NEW);    
    }
    if(Trigger.isDelete && Trigger.isBefore){
        CaseTriggerHandler.beforedeletehandler(Trigger.OLD);
    }
}