trigger LEADTrigger on Lead (before UPDATE,after insert,before delete) {
    if(Trigger.isUpdate && Trigger.isBefore){
        for(Lead lead: Trigger.NEW){
            lead.Status='Working - Contacted';
        }
    }
    if(Trigger.isInsert && Trigger.isAfter){
        LeadTaskHandler.leadtaskhandler(Trigger.NEW);
    }
    if(Trigger.isDelete && Trigger.isBefore){
        LeadTaskHandler.beforedeletehandler(Trigger.OLD);
    }
}