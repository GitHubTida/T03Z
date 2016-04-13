/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika_m@infosys.com
Date        : 29-Apr-15 
Description : This trigger is written to grant Read/Write access to Opportunity Owner for GSS
Ver       Date        Author                   Modification 
---       ---------   -----------              -------------------------
V0.1      29-Apr-15   Ragamalika Mohanraj      Initial Code
***************************************************************/

trigger ZEBSolutionAndServicesSharing on Custom_Services__c (after insert) {

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
try{  
List<Id> oppIdList =new List<Id>();
for( Custom_Services__c oppId : Trigger.new){
    oppIdList.add(oppId.Opportunity__c);
}

 // Null check loop Starts
 
  if(!oppIdList.isEmpty()){
Map<Id,Opportunity > mapOppOwner = new Map<Id,Opportunity>([SELECT Id,OwnerId from Opportunity WHERE Id IN:oppIdList]);

 
       
    List<Custom_Services__Share> serviceShareList = new List<Custom_Services__Share>();
    for(Custom_Services__c solutionService : trigger.new){
        if( mapOppOwner.get(solutionService.Opportunity__c).OwnerId <> solutionService.OwnerId){
        Custom_Services__Share SolutionsAndServicesShare = new Custom_Services__Share();
        SolutionsAndServicesShare.ParentId = solutionService.Id;
        SolutionsAndServicesShare.UserOrGroupId = mapOppOwner.get(solutionService.Opportunity__c).OwnerId;
        SolutionsAndServicesShare.AccessLevel = 'Edit';
       // SolutionsAndServicesShare.RowCause = Schema.Custom_Services__Share.RowCause.Opportunity__c;
        serviceShareList.add(SolutionsAndServicesShare);
        }
    }
     Database.SaveResult[] ServiceShareInsertResult = Database.insert(serviceShareList,false);
  }
     // Null check loop Ends
     
}

catch(Exception e)
        {
            System.debug('Validation Message : '+e.getMessage());
        }
}
}