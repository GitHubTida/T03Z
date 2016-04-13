/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Nikhil Kumar
    Date        : 12-OCT-15
    Revision History
    Ver       Date        Author            Modification
    ---       ---------   -----------       -------------------------
    V0.1      12-OCT-15   Nikhil Kumar   Initial Code(used to Tesseract integration)
 ***************************************************************/
trigger DD_StagingTrigger on DD_Staging_Table_Tesseract__c(Before insert,Before update,After insert,After update) {

    DD_StagingTriggerHandler handler = New DD_StagingTriggerHandler();
    
    If(trigger.isBefore && Trigger.isInsert ){
        handler.OnBeforeInsert(Trigger.New,Trigger.NewMap);
    }
    If(trigger.IsInsert&& Trigger.IsAfter){
        handler.OnAfterInsert(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }
    If(trigger.isBefore && Trigger.isupdate){
        handler.OnBeforeUpdate(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }
    
    If(trigger.isafter && Trigger.isupdate){
        handler.OnAfterUpdate(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }    
}