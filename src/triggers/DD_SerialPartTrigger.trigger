/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Nikhil Kumar
    Date        : 06-OCT-15
    Revision History
    Ver       Date        Author            Modification
    ---       ---------   -----------       -------------------------
    V0.1      06-OCT-15   Nikhil Kumar         Initial Code  
 ***************************************************************/



trigger DD_SerialPartTrigger on DD_Serial_Parts_Management__c(Before insert,Before update,After insert,After update) {

    DD_SerialPartTriggerHandler handler = New DD_SerialPartTriggerHandler();
    
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