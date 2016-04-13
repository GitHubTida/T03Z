/*******************************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika Mohanraj
Date        : 15-Dec-15
Description : This Trigger is used by CaseComment to call CaseHandler class based on the action. 

Revision History 
Ver       Date        Author             Modification 
---       ---------   -----------        -------------------------
V0.1      15-Dec-15   Ragamalika Mohanraj    Initial Code
 ********************************************************************************/

trigger pc_Trig_CaseComment on CaseComment(after insert) {
   TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Case');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    if(Trigger.isInsert && Trigger.isAfter){
        PC_CaseTriggerHandler.PC_CaseUpdateForNotificationEmail(Trigger.new,Trigger.newMap); 
    }
      
    
    }
}