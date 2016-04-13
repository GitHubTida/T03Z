/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Nikhil Kumar
    Date        : 25-Aug-15
    Revision History
    Ver       Date        Author            Modification
    ---       ---------   -----------       -------------------------
    V0.1      25-Aug-15   Nikhil Kumar         Initial Code  
 ***************************************************************/



trigger DD_MasterproductTrigger on DD_Master_Demo_Products__c(Before insert,Before update,After insert,After update) {

    DD_MasterProductTriggerHandler handler = New DD_MasterProductTriggerHandler();
    
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