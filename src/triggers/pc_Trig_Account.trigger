/*******************************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika Mohanraj
Date        : 17-Dec-15
Description : This Trigger is used by Account to call Account Handler class based on the action. 

Revision History 
Ver       Date        Author             Modification 
---       ---------   -----------        -------------------------
V0.1      17-Dec-15   Ragamalika Mohanraj    Initial Code
 ********************************************************************************/

trigger pc_Trig_Account on Account(after update) {
   TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Account');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    if(Trigger.isUpdate && Trigger.isAfter){
        PC_AccountTriggerHandler.PC_UpdateCompanyId(Trigger.new,Trigger.newMap,Trigger.oldMap); 
    }
      
    
    }
}