public class CaseTriggerHandler {
    public static void beforeinserthandler(List<Case> CaseRecords){
        for(Case caserecord: CaseRecords){
            if(caserecord.Origin == 'Phone'){
                caserecord.Priority='HIGH';
            }
            else {
                caserecord.Priority='LOW';
            }
        }
    }
    public static void beforedeletehandler(List<Case> CaseRecords){
        Id user_profile_id=UserInfo.getProfileId();
        Id system_admin_id=[SELECT Id,Name FROM Profile WHERE Name='System Administrator' LIMIT 1].id;
        for(Case case_record: CaseRecords){
            if(user_profile_id != system_admin_id){
                case_record.addError('You cannot delete records');
            }
        }
    }
	
}