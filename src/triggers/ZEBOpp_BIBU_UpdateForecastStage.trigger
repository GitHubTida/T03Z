/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Vishal Jujaray
Date        : 05-May-15
Description : This trigger is Created to update the field Forecast Stage based on Stage
Revision History
Ver       Date        Author           Modification
---       ---------   -----------      -------------------------
V0.1      05-May-15   Vishal Jujaray   Initial Code
 ***************************************************************/
trigger ZEBOpp_BIBU_UpdateForecastStage on Opportunity (before insert, before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    Record_Type__c OpptyOpenRecordTypeId = Record_Type__c.getValues('Zebra Opportunity');
 //   Record_Type__c OpptyClosedRecordTypeId = Record_Type__c.getValues('Closed Opportunity');
    Record_Type__c OpptyAutoConvertRecordTypeId = Record_Type__c.getValues('AutoConvert Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
        for(Opportunity Oppty: Trigger.new){
            if(Oppty.RecordTypeID != null ) {   
               // if(Oppty.RecordTypeID == OpptyOpenRecordTypeId.Record_Type_Id__c || Oppty.RecordTypeID == OpptyClosedRecordTypeId.Record_Type_Id__c || Oppty.RecordTypeID == OpptyAutoConvertRecordTypeId.Record_Type_Id__c) {                
               if(Oppty.RecordTypeID == OpptyOpenRecordTypeId.Record_Type_Id__c ||  Oppty.RecordTypeID == OpptyAutoConvertRecordTypeId.Record_Type_Id__c) {                
                    Oppty.Forecast_Stage__c = Oppty.StageName;
                }
            }
        }
    }
}