/**************************************************************************************************
* Name   : Address Validate AccountTrigger 
* Author : Shanthi Latharani
* Date   : 
* Purpose: To validate the address 
* 
* ======================================
* = MODIFICATION HISTORY =
* ======================================
* DATE              AUTHOR               CHANGE
* ----              ------               ------
* 06/JAN/2014     Shanthi Latharani      Created

***************************************************************************************************/
trigger AddressDoctorValidate on Account (after insert, after update) 
{
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Account');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
        // Start of Nimesh for Fix of PD Details when Acc PartnerEmpowerStatus becomes Inactive
        List<String> aclistForPD = new List<String>();
        List<PE_Program_Detail__c> PDList = new List<PE_Program_Detail__c>();
        if (Trigger.isupdate) {
            for (Account ac : Trigger.New) {
                Account objOldAccQ = Trigger.oldMap.get(ac.ID);
                if (objOldAccQ.PartnerEmpower_Program_Status__c != ac.PartnerEmpower_Program_Status__c && ac.PartnerEmpower_Program_Status__c == 'Inactive')
                    aclistForPD.add(ac.id);
            }
        }
        if (aclistForPD.size() > 0) {
            PDList =  [Select id, Status__c from PE_Program_Detail__c where Account__c in :aclistForPD];
            if(PDList.size() > 0){
                for(PE_Program_Detail__c pd: PDList){
                    pd.Status__c = 'Inactive';
                }
                update PDList;
            }
        }
        // End of Nimesh for Fix of PD Details when Acc PartnerEmpowerStatus becomes Inactive
        
        // Commented the below code to turn off the Address Doctor Callouts
        /*
        if(ZEBUtility.isNotZebraInterfaceUser()) {
            List<String> aclist = new List<String>();
                        
            
            if (!ZEBSfdcToAddressLookupCallout.futureCalloutContext ) {
                if(!ZEBUtility.inFutureCalloutContext){ 
                    
                    if (Trigger.isAfter) {
                        if(Trigger.isInsert){
                            for (Account ac : Trigger.New) {
                                // Bypassing the partner Accounts in Address Doctor Callouts as part of the CR CHG0044918  
                                if(((ac.billingstreet != null && ac.billingstreet != '') || (ac.billingcity != null && ac.billingcity != '') || (ac.BillingState != null && ac.BillingState != '') || (ac.billingcountry != null && ac.billingcountry != '') || (ac.billingPostalcode != null && ac.billingPostalcode != '')) && ac.account_type__c != 'Partner'){
                                    aclist.add(ac.id);
                                }
                            }
                        }
                        if (Trigger.isupdate) {
                            for (Account ac : Trigger.New) {
                                system.debug('____________________________AddressDoctorValidate111111 ___________');
                                Account objOldAccc = Trigger.oldMap.get(ac.ID);
                                // Bypassing the partner Accounts in Address Doctor Callouts as part of the CR CHG0044918 
                                if (ac.account_type__c != 'Partner' && (( (ac.billingstreet != null && ac.billingstreet != '')  && (!(ac.billingstreet.equals(objOldAccc.billingstreet))) ) || ((ac.billingcity != null && ac.billingcity != '')  && (!(ac.billingcity.equals(objOldAccc.billingcity)))) || ((ac.BillingStateCode != null && ac.BillingStateCode != '')  && (!(ac.BillingStateCode.equals(objOldAccc.BillingStateCode))) ) || ((ac.BillingState != null && ac.BillingState != '')  && (!(ac.BillingState.equals(objOldAccc.BillingState))))  || ((ac.billingPostalcode != null && ac.billingPostalcode != '')  && (!(ac.billingPostalcode.equals(objOldAccc.billingPostalcode)))) || ((ac.billingcountry != null && ac.billingcountry != '')  && (!(ac.billingcountry.equals(objOldAccc.billingcountry))))) )
                                aclist.add(ac.id);
                            }
                        }
                    }
                    system.debug('____________________________AddressDoctorValidate ___________');
                    if (aclist.size() > 0) {
                        Turning Off Address Doctor Temparorily
                        InformaticaAddressvalidateCalloutFuture.getAddressvalidateINformatica(aclist);
                    }
                }
            }
        }  */
        // Commented the above code to turn off the Address Doctor Callouts
    }
}