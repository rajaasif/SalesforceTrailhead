trigger Contact_Trigger on Contact (before insert,after insert,after update) {
    if(Trigger.isInsert && Trigger.isBefore){
        ContactTriggerHandler.beforeinsertContactHandler(Trigger.NEW);
    }
    if(Trigger.isInsert && Trigger.isAfter){
        ContactTriggerHandler.afterinsertContactHandler(Trigger.NEW);
        ContactTriggerHandler.createNlocations(Trigger.NEW,null);
        
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        ContactTriggerHandler.sendmailContactHandler(Trigger.NEW,Trigger.OLDMap);
        ContactTriggerHandler.createNlocations(Trigger.NEW,Trigger.oldMap);
    }
}