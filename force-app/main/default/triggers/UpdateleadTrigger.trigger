trigger UpdateleadTrigger on Lead (before update) {
    if(Trigger.isUpdate && Trigger.isBefore){
        for(Lead leadrecords: Trigger.NEW){
            if(leadrecords.Industry == 'HealthCare'){
                leadrecords.LeadSource='Purchased List';
                leadrecords.SICCode__c='1100';
                leadrecords.Primary__c='yes';
            }
        }
    }
}