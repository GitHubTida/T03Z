/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Nikhil Kumar
    Date        : 25-Aug-15
    Revision History
    Ver       Date        Author            Modification
    ---       ---------   -----------       -------------------------
    V0.1      25-Aug-15   Nikhil Kumar         Initial Code  
 ***************************************************************/



trigger DD_UpdatedemoStautus on DD_Reserved_Product__c (Before insert,Before update,After insert,After update) {

    DD_ReserveProductTriggerHandler handler = New DD_ReserveProductTriggerHandler();
    
    If(trigger.isBefore && Trigger.isupdate){
        handler.OnBeforeUpdate(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }
    
    If(trigger.isafter && Trigger.isupdate){
        handler.OnAfterUpdate(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }    
}