/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Kushal Soni
    Date        : 11-May-15
    Description : This trigger is written to update Is Service Product based on Product Line.
    Revision History:
    Ver       Date        Author           Modification
    ---       ---------   -----------      -------------------------
    V0.1      11-Aug-15   Kushal Soni      Initial Code
    
 ***************************************************************/

trigger UpdateServiceProduct on Named_Product_Family__c(before insert, before update){

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){

   for (Named_Product_Family__c namedProdFamily: Trigger.new){
    
        if (namedProdFamily.Product_Line__c == 'Aftermarket Services' || 
            namedProdFamily.Product_Line__c == 'EMB ADVANCED SVCS'|| 
            namedProdFamily.Product_Line__c == 'EMB REPAIR SERVICES')
            {
              namedProdFamily.Is_Service_Product__c = true;
            }
        else{ 
             namedProdFamily.Is_Service_Product__c = false;
            }
    }
  }
}