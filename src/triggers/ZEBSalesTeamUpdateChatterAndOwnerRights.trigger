/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika_m@infosys.com
Date        : 29-Apr-15 
Description : This trigger is written to grant or revoke Read/Write access to Opportunity Team member for GSS and to give chatter Notification when Service sales user is added to Opportunity Team. 
Ver       Date        Author                   Modification 
---       ---------   -----------              -------------------------
V0.1      29-Apr-15   Ragamalika Mohanraj      Initial Code
v0.2      29-Feb-16   Priyanka Pillala         Added code to share and unshare Deal Registration associated to
                                               Oppty on addition/removal of Oppty Sales Team
*************************************************************************************************************/

trigger ZEBSalesTeamUpdateChatterAndOwnerRights on OpportunityTeamMember (after insert, before delete) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c)
        try{
            // on insert access rights and chatter notification provided.
            if(Trigger.IsInsert) {
            Map<ID, String> oppMap = new Map<ID, String>();
            List<ID> opportunityFeedList = new List<Id>();
            List <FeedItem> chatterPostsToAdd = new List <FeedItem>() ;
            for(OpportunityTeamMember oppTeam: Trigger.new){      
                opportunityFeedList.add(oppTeam.Opportunityid);  
            }
            // Null check loop Starts
            if(!opportunityFeedList.isEmpty()){
                List<Opportunity> oppList = [Select ID, name from Opportunity where Id =:opportunityFeedList];     
                for(Opportunity opp:oppList){
                    oppMap.put(opp.id, opp.name);
                    
                }
                for(OpportunityTeamMember oppTeam: Trigger.new){
                    if(oppTeam.TeamMemberRole == 'GSS Account Manager/Engagement Manager'){
                        FeedItem oppTeamPost = new FeedItem();
                        oppTeamPost.ParentID = oppTeam.UserId;
                        oppTeamPost.Body = 'You have been added as Opportunity Sales Team Member in the Opportunity: '+oppMap.get(oppTeam.opportunityId) +' with Role '+oppTeam.TeamMemberRole;
                        chatterPostsToAdd.add(oppTeamPost);
                    }
                }
                if(chatterPostsToAdd.size() > 0)
                    insert chatterPostsToAdd;
                //Added by Priyanka - START
                List<Deal_Registration__c> drList = new List<Deal_Registration__c>();
                List<Deal_Registration__Share> drShareList = new List<Deal_Registration__Share>();
                drList = [SELECT Id, Opportunity__c FROM Deal_Registration__c WHERE Opportunity__c IN :opportunityFeedList];
                //Added by Priyanka - END
                // Start of added by nimesh to give read write access to team member of GSS record
                List<Custom_Services__Share> ServiceShareList = new List<Custom_Services__Share>();
                List<Custom_Services__c> serviceList =new List<Custom_Services__c>([SELECT Id,OwnerId,Opportunity__r.Id FROM Custom_Services__c WHERE Opportunity__c IN : opportunityFeedList]);
                for(OpportunityTeamMember oppTeamRec: Trigger.new){
                    if(oppTeamRec.TeamMemberRole == 'GSS Account Manager/Engagement Manager'){
                        for(Custom_Services__c sl: serviceList){  
                            if(oppTeamRec.Opportunityid == sl.Opportunity__c){
                                Custom_Services__Share SolutionsAndServicesShare = new Custom_Services__Share();
                                SolutionsAndServicesShare.ParentId = sl.Id;
                                SolutionsAndServicesShare.UserOrGroupId = oppTeamRec.UserId;
                                SolutionsAndServicesShare.AccessLevel = 'Edit';
                                ServiceShareList.add(SolutionsAndServicesShare);
                            }
                        }
                    }
                    //Added by Priyanka - START
                    for(Deal_Registration__c d : drList){
                        Deal_Registration__Share dShare = new Deal_Registration__Share(ParentID = d.Id, UserOrGroupId = oppTeamRec.userId, AccessLevel = 'Read');
                        drShareList.add(dShare);
                    }
                    //Added by Priyanka - END
                }
                if(!ServiceShareList.isempty())
                    Database.SaveResult[] ServiceShareInsertResult = Database.insert(ServiceShareList,false);
                //Added by Priyanka
                if(drShareList.size() > 0)
                        insert drShareList;
             
            }
            }
            
            //On deleting an Opportunity Team member access to GSS revoked.
            if(Trigger.IsDelete) {
             List<Id> opportunityIdList = new List<Id>();
        
        List<Id> deleteShare = new List<Id>();
        //Added by Priyanka
        Map<Id,Id> oppTeamMemToOppIdMap = new Map<Id,Id>();
        for(OpportunityTeamMember oppTeamMem : trigger.old){
            
                if(oppTeamMem.TeamMemberRole == 'GSS Account Manager/Engagement Manager')
           
                opportunityIdList.add(oppTeamMem.OpportunityId);
                system.debug('****'+oppTeamMem.OpportunityId);
                //Added by Priyanka
                oppTeamMemToOppIdMap.put(oppTeamMem.UserId,oppTeamMem.OpportunityId);
            }
            
            //Deleting sharing for Deal Regs
            //Added by Priyanka - START
            List<Deal_Registration__c> drList1 = new List<Deal_Registration__c>();
            List<Deal_Registration__Share> drShareList1 = new List<Deal_Registration__Share>();
            List<Deal_Registration__Share> drDelShareList = new List<Deal_Registration__Share>();
            drList1 = [SELECT Id, Opportunity__c FROM Deal_Registration__c WHERE Opportunity__c IN :oppTeamMemToOppIdMap.values()];
            Map<Id,Id> dealtoOppIDMap = new Map<Id,Id>();
            for(Deal_Registration__c m : drList1)
                dealtoOppIDMap.put(m.Id,m.Opportunity__c);
            if(dealtoOppIDMap.size() > 0 && oppTeamMemToOppIdMap.size() > 0){
                drShareList1 = [SELECT Id, ParentId, UserOrGroupId FROM Deal_Registration__Share WHERE UserOrGroupID in :oppTeamMemToOppIdMap.keySet() and ParentId IN :dealtoOppIDMap.keySet()];
                for(Deal_Registration__Share ds : drShareList1){
                    if(dealtoOppIDMap.get(ds.ParentId) == oppTeamMemToOppIdMap.get(ds.UserOrGroupID))
                        drDelShareList.add(ds);
                }
            }
            if(drDelShareList.size() > 0)
                delete drDelShareList;
            //Added by Priyanka - END
        
      List<Custom_Services__Share> ServiceShareDeleteList = new List<Custom_Services__Share>();
                List<Custom_Services__c> deleteServiceList =new List<Custom_Services__c>([SELECT Id,OwnerId,Opportunity__r.Id FROM Custom_Services__c WHERE Opportunity__r.Id IN : opportunityIdList]);
                for(OpportunityTeamMember oppTeam: Trigger.old){
                    if(oppTeam.TeamMemberRole == 'GSS Account Manager/Engagement Manager'){
                        for(Custom_Services__c sl: deleteServiceList){  
                            if(oppTeam.Opportunityid == sl.Opportunity__c){
                deleteShare.add(sl.Id);}
                    
                }
                }}
          
           //deleting old sharing from old opportunity Team member
           
           if (!deleteShare.isEmpty()){
                List<Custom_Services__Share> listDeleteShare = new List<Custom_Services__Share>([select id from Custom_Services__Share where ParentId IN : deleteShare AND RowCause = 'Manual']);
                delete listDeleteShare;
                }
            
        }
        // Null check loop Ends
        }
              
       catch(Exception e){
                System.debug('Validation Message : '+e.getMessage());
        }
   }