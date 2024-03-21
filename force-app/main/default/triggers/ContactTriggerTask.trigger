trigger ContactTriggerTask on Contact (before insert,before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ContactTaskhandler.beforeinserthandler(Trigger.NEW);
        }
        else if(Trigger.isUpdate){
            //ContactTaskhandler.beforeinserthandler(Trigger.NEW);
        }
    }
	
}