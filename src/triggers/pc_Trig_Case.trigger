/*******************************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika Mohanraj
Date        : 15-Dec-15
Description : This Trigger is used by Case to call CaseHandler class based on the action. 

Revision History 
Ver       Date        Author             Modification 
---       ---------   -----------        -------------------------
V0.1      15-Dec-15   Ragamalika Mohanraj    Initial Code
 ********************************************************************************/

trigger pc_Trig_Case on Case(before update,after update,after insert) {
   TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Case');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    if(Trigger.isUpdate && Trigger.isAfter){
        PC_CaseTriggerHandler.PC_CaseCommentOnCaseClose(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldMap); 
    // PC_CaseTriggerHandler.PC_UpdateCaseOwnerLanguage(Trigger.new);
    
    }
      
    if(Trigger.isUpdate && Trigger.isBefore ){
        
        PC_CaseTriggerHandler.PC_UpdateCaseOwner(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldMap);
    }
    
   
    
    
    }
}