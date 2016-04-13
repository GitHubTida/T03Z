/**************************************************************************************************
* Name   : ZEBEVMPEForCurrency
* Author : Priyanka_Singh33@infosys.com
* Date   : 25-Mar-2015 
* Purpose: This trigger is maps the date to null if 1 1 2000 
* 
* REVISION HISTORY 
* ======================================
* DATE              AUTHOR               CHANGE
* ----              ------               ------  
 25-Mar-2015        Priyanka Singh       Initial Code
 16-Sep-2015        Manjunath CS         added the Update logic to nullify the Data.
 16-Sep-2015        Priyanka Singh       added the insert logic to nullify the Approved Date.
***************************************************************************************************/
trigger ZEBEVMPEForCurrency on Price_Exception__c (before insert, before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Price Exception');
    if(objTriggerDeactivate.IsTriggerActive__c){
      for (Price_Exception__C pe:Trigger.new){
              pe.name=pe.Quote_ID__c;
              if(pe.Approved_Date__c==Date.newInstance(2000, 1, 01))
                   pe.Approved_Date__c=null;
            
      }
    }
}