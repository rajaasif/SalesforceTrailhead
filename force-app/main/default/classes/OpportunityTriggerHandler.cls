public class OpportunityTriggerHandler {
    public static void afterUpdateHandler(List<Opportunity> newrecords){
        List<Task> task_list=new List<Task>();
        List<Id> opp_ids=new List<Id>();
        List<OpportunityTeamMember> listtodelete=new List<OpportunityTeamMember>();
        for(Opportunity opp: newrecords){
            opp_ids.add(opp.Id);
        }
        System.debug(opp_ids);
        List<OpportunityTeamMember> team_members=[SELECT Id,OpportunityId FROM OpportunityTeamMember WHERE OpportunityId IN :opp_ids];
        for(Opportunity opp: newrecords){
            if(opp.StageName=='Closed Won'){
                Task task=new Task();
                task.OwnerId=opp.OwnerId;
                task.WhatId=opp.Id;
                task.Description='Split the revenue amongst teh team members';
                task.Priority='High';
                task.Status='Not Started';
                task.Subject='Split Revenue';
                task_list.add(task);
                
            }
            else if(opp.StageName == 'Closed Lost'){
                for(OpportunityTeamMember t_member: team_members){
                    if(t_member.OpportunityId == opp.Id){
                        listtodelete.add(t_member);
                        System.debug(t_member.OpportunityId);
                    }
                }
            }
        }
        if(!task_list.isEmpty()){
            insert task_list;
        }
        if(!listtodelete.isEmpty()){
            System.debug('Found Members');
            delete listtodelete;
        }
          
    }
    public static void beforeUpdateHandler(List<Opportunity> newRecords,Map<id,Opportunity> oldMap){
        for(Opportunity newopp: newRecords){
            if(oldMap.get(newopp.id).StageName != newopp.StageName){
                newopp.Amount=newopp.Probability * newopp.ExpectedRevenue;
            }
        }
        
    }
    public static void afterDeleteHandler(List<Opportunity> oldrecords){
        Set<Id> acc_ids=new Set<Id>();
        Map<id,id> oppvsacc=new map<id,id>();
        Map<Id,Id> accvsOwnerid= new Map<Id,Id>();
        for(Opportunity opp: oldrecords){
            acc_ids.add(opp.AccountId);
            oppvsacc.put(opp.Id,opp.AccountId);
        }
        List<Account> acc_list=[SELECT Id,OwnerId FROM Account WHERE Id IN :acc_ids];
        for(Account acc: acc_list){
            accvsOwnerid.put(acc.Id,acc.OwnerId);
        }
        List<Task> tasklist= new List<Task>();
        for(Opportunity opp: oldrecords){
            Task task=new Task();
            task.OwnerId=accvsOwnerid.get(oppvsacc.get(opp.Id));
            task.Description='This opp is deleted: ' + opp.Id + ' please investigate.' ;
            task.Subject='Investigate';
            task.Status='Not Started';
            task.Priority='High';
            tasklist.add(task);
            
        }
        if(!tasklist.isEmpty()){
            try{
                insert tasklist;
            System.debug('Task created ');
            }
            catch(DMLException e){
                System.debug('Following error occurred: '+ e.getMessage());
            }
            
        }
    }
    public static void addteamMembersHandler(List<Opportunity> newRecords,Map<id,Opportunity> oldMap){
        List<OpportunityTeamMember> teammembers=new List<OpportunityTeamMember>();
        List<User> opportunist=[SELECT id ,UserRole.Name FROM User WHERE UserRole.Name='opportunist'];
        for(Opportunity opp: newRecords){
            if(opp.StageName != oldMap.get(opp.Id).StageName && opp.StageName=='Needs Analysis'){
                for(User user: opportunist){
                    OpportunityTeamMember team_members=new OpportunityTeamMember();
                	team_members.Userid=user.Id;
                	team_members.OpportunityId=opp.Id;
                    team_members.OpportunityAccessLevel='Edit';
                    teammembers.add(team_members);
                }  
            }
        }
        if(!teammembers.isEmpty()){
            try{
                insert teammembers;
            }
            catch(DMLException e){
                System.debug('Following error occured: '+ e.getMessage());
            }
        }
    }
}