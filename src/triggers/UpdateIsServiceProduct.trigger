/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Priyanka Singh
    Date        : 12-May-15
    Description : This trigger is written to update Is Service Product based on record type.
    Revision History:
    Ver       Date        Author           Modification
    ---       ---------   -----------      -------------------------
    V0.1      12-May-15   Priyanka Singh     Initial Code
    V0.2      14-May-15   Nimesh Sharma      Removed recordtype.DeveloperName
    v0.3      14-May-15   priyanka Singh     added recordtypeId through query
 ***************************************************************/

trigger UpdateIsServiceProduct on Product2(before insert, before update){

Id serviceRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Service Products').getRecordTypeId();
Id hardwareRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Hardware Products').getRecordTypeId();

/*  This is to update the 'Is Service Product' checkbox true if recordtype is equals to 'Service Products'
        else 'Is Service Product' checkbox should be false */
    
    for (Product2 prod: Trigger.new){
        prod.CanUseQuantitySchedule = true;
        prod.CanUseRevenueSchedule = true;
        if (prod.Product_Line__c == 'Aftermarket Services' || 
            prod.Product_Line__c == 'EMB ADVANCED SVCS'|| 
            prod.Product_Line__c == 'EMB REPAIR SERVICES'){
              prod.recordtypeid = serviceRecordTypeId;
              prod.Is_Service_Product__c = true;
          }
        else{ 
          prod.recordtypeid = hardwareRecordTypeId;
          prod.Is_Service_Product__c = false;
        }
    }
}