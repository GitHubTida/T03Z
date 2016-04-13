/*******************************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Kushal_Soni01@infosys.com
Date        : 09-Mar-15 
Description : Trigger to insert partners, sales team present in a Clone Queue object to a cloned Opportunity
Revision History 
Ver       Date        Author           Modification 
---       ---------   -----------      -------------------------
V0.1      09-Mar-15   Kushal Soni      Initial Code
V0.2      20-Mar-15   Vishal Rao       Included the Cloned From functionality
 ********************************************************************************/

trigger ZEBOpportunity_CloneExecution on Opportunity (before insert, after insert) {

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
    
    //Declarations
    Opportunity[] opps = Trigger.new;

    Clone_Queue__c[] cq = [SELECT id, Partners__c, Sales_Team__c, CreatedDate, Opportunity__c from Clone_Queue__c WHERE  OwnerId=:opps[0].OwnerId ORDER BY CreatedDate DESC];
    
    //Commented by Nitin - 23-Mar-2015. As this was throwing 'List Index Out Of Bounds' error during 'Before Insert' of Opportunity
    // Uncommented by Vishal - 23-Mar-2015. Included a condition to execute only when the queue has atleast one record
      if (Trigger.isbefore && cq.size()>0){
       opps[0].Cloned_From__c = cq[0].Opportunity__c;
       opps[0].Siebel_Opp_Id__c ='';
       opps[0].EVM_Opportunity_ID__c='';
    }     
    
    else {
    //Checking if Clone Queue is not empty and inserting Partners and Sales team to the Cloned Opportunity
    if(cq.size()>0){
    
        if(cq[0].Partners__c){
            OpportunityPatner__c[] copiedPartners = new OpportunityPatner__c[0];
            for(OpportunityPatner__c a:[SELECT Patner__c, Role__c, Opportunity__c from OpportunityPatner__c WHERE Opportunity__c=:cq[0].Opportunity__c]){
                System.debug('ssssss---a'+a);
                if(a.Patner__c!=null)
                    copiedPartners.add(new OpportunityPatner__c(Patner__c=a.Patner__c, Role__c=a.Role__c, Opportunity__c=opps[0].Id));
                
            }
            if(copiedPartners.size()>0)
                insert copiedPartners;
        }
        if(cq[0].Sales_Team__c){
            OpportunityTeamMember[] copiedMembers = new OpportunityTeamMember[0];
            Id[] userIds = new Id[0];
            for(OpportunityTeamMember b:[SELECT OpportunityAccessLevel, TeamMemberRole, UserId, OpportunityId from OpportunityTeamMember WHERE OpportunityId=:cq[0].Opportunity__c]){
                copiedMembers.add(new OpportunityTeamMember(TeamMemberRole=b.TeamMemberRole, UserId=b.UserId, OpportunityId=opps[0].Id));
                userIds.add(b.UserId);
            }
            if(copiedMembers.size()>0){
                Map<ID, User> m = new Map<ID, User>([select id, isactive from user where id IN :userIds]);
                
                for(Integer c=copiedMembers.size()-1; c>=0; c--){
                    if(!( m.get(copiedMembers[c].UserId).IsActive) )
                        copiedMembers.remove(c);
                }               
                insert copiedMembers;
            }
        }
        //Inserting the tasks
        Task nt = new Task(ActivityDate=System.today(), Status='Completed', OwnerId=opps[0].OwnerId, WhatId=cq[0].Opportunity__c, Subject='This Opportunity was Cloned', Description='On this date a clone of this opportunity was created with Id = '+ Opps[0].Id);
        insert nt;

        delete cq;
    }
    }
}}