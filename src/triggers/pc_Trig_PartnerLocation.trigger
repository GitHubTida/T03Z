/*******************************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika Mohanraj
Date        : 22-Jan-15
Description : This Trigger is used to check if Primary Location is removed

Revision History 
Ver       Date        Author             Modification 
---       ---------   -----------        -------------------------
V0.1      22-Jan-15   Ragamalika Mohanraj    Initial Code
 ********************************************************************************/

trigger pc_Trig_PartnerLocation on Partner_Location__c (before update, before delete) {
  TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Account');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    if(Trigger.isUpdate && Trigger.isBefore){
        PC_PartnerLocationTriggerHandler.PC_PrimaryLocationConstraint(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldMap); 
        PC_PartnerLocationTriggerHandler.PC_PrimaryLocationUpdateConstraint(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldMap); 
    }
     if((Trigger.isDelete && Trigger.isBefore)){
        PC_PartnerLocationTriggerHandler.PC_PrimaryLocationDeleteConstraint(Trigger.new,Trigger.old,Trigger.newMap,Trigger.oldMap); 
    } 
    
    }
}