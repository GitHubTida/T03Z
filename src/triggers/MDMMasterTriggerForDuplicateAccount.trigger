/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Rajesh kumar 
    Date        : 21-June-15
    Description : This trigger handler class is written to cover all the trigger written on Duplicate Account object.
  
 ***************************************************************/
Trigger MDMMasterTriggerForDuplicateAccount on DSE__DS_Duplicates__c (before insert) 
{
   system.debug('Trigger handler ttttttttttttttttt');
  TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Duplicate Accounts');
   if(objTriggerDeactivate.IsTriggerActive__c)
    { 
       MDMDuplicateAccountTriggerHandler handler = new MDMDuplicateAccountTriggerHandler();  
       if (Trigger.isBefore && Trigger.isInsert)
        handler.BeforeInsert(Trigger.New);
     }
}