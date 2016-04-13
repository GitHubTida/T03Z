/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Nikhil Kumar
    Date        : 18-Sept-15
    Revision History
    Ver       Date        Author            Modification
    ---       ---------   -----------       -------------------------
    V0.1      18-Sept-15   Nikhil Kumar         Initial Code  
 ***************************************************************/



trigger DD_UserTrigger on User(Before insert,Before update,After insert,After update) {

    DD_UserTriggerHandler handler = New DD_UserTriggerHandler();
    
    If(trigger.isBefore && Trigger.isupdate){
        handler.OnBeforeUpdate(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }
    
    If(trigger.isafter && Trigger.isupdate){
        handler.OnAfterUpdate(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }    
}