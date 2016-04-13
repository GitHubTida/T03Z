/**************************************************************************************************
 * Name   : ZEBPartnerAccountCalloutTrigger
 * Author : Nitin Shivashankara
 * Date   : 05-Nov-2015
 * Purpose: This trigger makes a web service callout to Siebel via Informatica for Partner Accounts
 * ======================================
 * = MODIFICATION HISTORY =
 * ======================================
 * DATE            AUTHOR                   CHANGE
 * ----            ------                   ------
 * 05-Nov-2015     Nitin Shivashankara      Created
 ***************************************************************************************************/
trigger ZEBPartnerAccountCalloutTrigger on Account (after update){
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Partner Account Update');
    Boolean makeCallout = false;
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        if(ZEBUtility.isNotZebraInterfaceUser() ) {
            List<String> accountIdList = new List<String>();
            if(!ZEBUtility.inFutureCalloutContext){
                for(Account acct: trigger.new){
                    if(acct.Account_Type__c == 'Partner' && acct.Siebel_Row_Id__c != null && 
                        (acct.Account_Status__c != Trigger.oldMap.get(acct.Id).Account_Status__c ||
                        acct.ZEB_Status_Change_Reason__c != Trigger.oldMap.get(acct.Id).ZEB_Status_Change_Reason__c ||
                        acct.CurrencyISOCode != Trigger.oldMap.get(acct.Id).CurrencyISOCode ||
                        acct.Fax != Trigger.oldMap.get(acct.Id).Fax ||
                        acct.Phone != Trigger.oldMap.get(acct.Id).Phone ||
                        acct.Name != Trigger.oldMap.get(acct.Id).Name ||
                        acct.Price_List__c != Trigger.oldMap.get(acct.Id).Price_List__c ||
                        acct.Organization__c != Trigger.oldMap.get(acct.Id).Organization__c ||
                        acct.Account_Type__c != Trigger.oldMap.get(acct.Id).Account_Type__c ||
                        acct.Third_Party_Id__c != Trigger.oldMap.get(acct.Id).Third_Party_Id__c ||
                        acct.Third_Party__c != Trigger.oldMap.get(acct.Id).Third_Party__c ||
                        acct.Translated_Name__c != Trigger.oldMap.get(acct.Id).Translated_Name__c ||
                        acct.Website != Trigger.oldMap.get(acct.Id).Website ||
                        acct.Company_Id_Type__c != Trigger.oldMap.get(acct.Id).Company_Id_Type__c ||
                        acct.Partner_Locator_Company_Description__c != Trigger.oldMap.get(acct.Id).Partner_Locator_Company_Description__c ||
                        acct.Partner_Locator_Permisson_Granted__c != Trigger.oldMap.get(acct.Id).Partner_Locator_Permisson_Granted__c ||
                        acct.Primary_Address_Row_Id__c != Trigger.oldMap.get(acct.Id).Primary_Address_Row_Id__c ||
                        acct.BillingCity != Trigger.oldMap.get(acct.Id).BillingCity ||
                        acct.BillingCountry != Trigger.oldMap.get(acct.Id).BillingCountry ||
                        acct.BillingPostalCode != Trigger.oldMap.get(acct.Id).BillingPostalCode ||
                        acct.BillingStateCode != Trigger.oldMap.get(acct.Id).BillingStateCode ||
                        acct.BillingStreet != Trigger.oldMap.get(acct.Id).BillingStreet ||
                        acct.ShippingCity != Trigger.oldMap.get(acct.Id).ShippingCity ||
                        acct.ShippingCountry != Trigger.oldMap.get(acct.Id).ShippingCountry ||
                        acct.ShippingPostalCode != Trigger.oldMap.get(acct.Id).ShippingPostalCode ||
                        acct.ShippingStateCode != Trigger.oldMap.get(acct.Id).ShippingStateCode ||
                        acct.ShippingStreet != Trigger.oldMap.get(acct.Id).ShippingStreet ||
                        acct.Sellable_Area_Resellers_Distributors__c != Trigger.oldMap.get(acct.Id).Sellable_Area_Resellers_Distributors__c
                        ))
                        accountIdList.add(acct.Id);
                }
                if(accountIdList.size() > 0){
                        ZEBWebServiceCalloutFuture.createSFDCtoSiebelPartnerAccountUpdateFuture(accountIdList,null,'Update');
                }
            }
        }
    }
}