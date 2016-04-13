/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Nikhil Kumar
    Date        : 01-OCT-15
    Revision History
    Ver       Date        Author            Modification
    ---       ---------   -----------       -------------------------
    V0.1      01-OCT-15   Nikhil Kumar         Initial Code  
 ***************************************************************/



trigger DD_ProductOnOrderTrigger on DD_Product_on_Order__c (Before insert,Before update,After insert,After update) {

    DD_ProductOnOrderHandler handler = New DD_ProductOnOrderHandler();
    
    If(trigger.isBefore && Trigger.isInsert && DD_GeneralUtility.NotRunOnBinUpdate==true){
        handler.OnBeforeInsert(Trigger.New,Trigger.NewMap);
    }
    
    If(trigger.isBefore && Trigger.isupdate && DD_GeneralUtility.NotRunOnBinUpdate==true){
        handler.OnBeforeUpdate(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }
    
    If(trigger.isafter && Trigger.isupdate){
        handler.OnAfterUpdate(Trigger.old,Trigger.New,Trigger.OldMap,Trigger.NewMap);
    }    
}