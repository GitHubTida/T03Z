/**************************************************************************************************
* Name   : Account Cleanse Flag Trigger 
* Author : Shanthi Latharani
* Date   : 
* Purpose: To update the account cleanse flag
* 
* ======================================
* = MODIFICATION HISTORY =
* ======================================
* DATE              AUTHOR               CHANGE
* ----              ------               ------
* 06/JAN/2014     Shanthi Latharani      Created
* 11/FEB/2016     Vishal Jujaray         Deactivated this trigger as part of turning off the Address doctor
***************************************************************************************************/

trigger AccountCleanseFlag on Account (before update) {
TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Account');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    if(ZEBUtility.isNotZebraInterfaceUser() ) {
for(Account ac : Trigger.new){
  Account objOldAccc = Trigger.oldMap.get(ac.ID);
 if(( (ac.billingstreet!= null && ac.billingstreet!= '')  && (!(ac.billingstreet.equals(objOldAccc.billingstreet))) ) || 
     ((ac.billingcity!= null && ac.billingcity!= '')  && (!(ac.billingcity.equals(objOldAccc.billingcity)))) || 
     ((ac.BillingStateCode!= null && ac.BillingStateCode!= '')  && (!(ac.BillingStateCode.equals(objOldAccc.BillingStateCode))) ) || 
     ((ac.BillingState!= null && ac.BillingState!= '')  && (!(ac.BillingState.equals(objOldAccc.BillingState))))  || 
     ((ac.billingPostalcode!= null && ac.billingPostalcode!= '')  && (!(ac.billingPostalcode.equals(objOldAccc.billingPostalcode)))) || 
     ((ac.billingcountry!= null && ac.billingcountry!= '')  && (!(ac.billingcountry.equals(objOldAccc.billingcountry)))) ||
     ((ac.Name!= null && ac.Name!= '')  && (!(ac.Name.equals(objOldAccc.Name)))) ||
     (ac.Registered_Partner__c!=objOldAccc.Registered_Partner__c) ||
     ((ac.Organization__c!= null && ac.Organization__c!= '')  && (!(ac.Organization__c.equals(objOldAccc.Organization__c)))) ||
     ((ac.CurrencyIsoCode!= null && ac.CurrencyIsoCode!= '')  && (!(ac.CurrencyIsoCode.equals(objOldAccc.CurrencyIsoCode)))) ||
     ((ac.Account_Type__c!= null && ac.Account_Type__c!= '')  && (!(ac.Account_Type__c.equals(objOldAccc.Account_Type__c)))) ||
     ((ac.MSI_E_Account__c!= null && ac.MSI_E_Account__c!= '')  && (!(ac.MSI_E_Account__c.equals(objOldAccc.MSI_E_Account__c)))) ||
     ((ac.AccountNumber!= null && ac.AccountNumber!= '')  && (!(ac.AccountNumber.equals(objOldAccc.AccountNumber)))) ||
     ((ac.EVM_Account_ID__c!= null && ac.EVM_Account_ID__c!= '')  && (!(ac.EVM_Account_ID__c.equals(objOldAccc.EVM_Account_ID__c)))) ||
     ((ac.Siebel_Row_Id__c!= null && ac.Siebel_Row_Id__c!= '')  && (!(ac.Siebel_Row_Id__c.equals(objOldAccc.Siebel_Row_Id__c)))) ||
     (ac.Financial_Customer_Flag__c!=objOldAccc.Financial_Customer_Flag__c) ||
     ((ac.DSE__Domain__c!= null && ac.DSE__Domain__c!= '')  && (!(ac.DSE__Domain__c.equals(objOldAccc.DSE__Domain__c)))) ||
     (ac.Parent!=objOldAccc.Parent) ||
     ((ac.Phone!= null && ac.Phone!= '')  && (!(ac.Phone.equals(objOldAccc.Phone)))) ||
     (ac.RecordTypeId!=objOldAccc.RecordTypeId) ||
     (ac.DSE__DS_Synchronize__c!=objOldAccc.DSE__DS_Synchronize__c) ||
     ((ac.Website!= null && ac.Website!= '')  && (!(ac.Website.equals(objOldAccc.Website)))) ||
     
     ((ac.Account_Conversion_Source__c!= null && ac.Account_Conversion_Source__c!= '')  && (!(ac.Account_Conversion_Source__c.equals(objOldAccc.Account_Conversion_Source__c)))) 
     )
   {    
ac.Account_cleansed_flag__c = FALSE;
}
}
}
}
}