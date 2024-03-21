trigger Opp_Task_Trigger on Opportunity (after update,before update,after delete) {
    
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHandler.afterUpdateHandler(Trigger.NEW);
        OpportunityTriggerHandler.addteamMembersHandler(Trigger.NEW,Trigger.oldMap);
    }
    if(Trigger.isUpdate && Trigger.isBefore){
         OpportunityTriggerHandler.beforeUpdateHandler(Trigger.NEW,Trigger.oldMap);
        
    }
    if(Trigger.isDelete && Trigger.isAfter){
         OpportunityTriggerHandler.afterDeleteHandler(Trigger.OLD);
    }
}