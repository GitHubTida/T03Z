trigger ZEBAccount_bUPD on Account (before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Account');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){ 
    if(!ZEBUtility.inFutureCalloutContext){
        for(Account tempAcc: Trigger.new){
            Account oldAccObj = Trigger.oldMap.get(tempAcc.Id);
            if(tempAcc.Owner_Theater__c == 'APAC' && tempAcc.APAC_Organization__c != null){
                tempAcc.Organization__c =tempAcc.APAC_Organization__c;
            }else{
                tempAcc.APAC_Organization__c = null;
            }
            // Start of Changes by Nimesh : NCR and Registered Checks for partners flowing in from MSI - 29/05 
            if(tempAcc.Account_Type__c == 'Partner' && oldAccObj.of_Active_Ent_Technologies__c != tempAcc.of_Active_Ent_Technologies__c && tempAcc.of_Active_Ent_Technologies__c == 0  ){
                if(oldAccObj.Account_Type__c != 'Non Classified Reseller'){
                    tempAcc.Account_Type__c = 'Non Classified Reseller';
                    tempAcc.Registered_Partner__c = true;
                }
            }if(tempAcc.Account_Type__c == 'Partner' && oldAccObj.of_Ent_Technologies__c != tempAcc.of_Ent_Technologies__c && tempAcc.of_Ent_Technologies__c == 0  ){
                if(oldAccObj.Account_Type__c != 'Non Classified Reseller'){
                    tempAcc.Account_Type__c = 'Non Classified Reseller';
                    tempAcc.Registered_Partner__c = false;
                }
            }if(tempAcc.Account_Type__c == 'Non Classified Reseller' && oldAccObj.of_Active_Ent_Technologies__c != tempAcc.of_Active_Enterprise_Technologies__c && tempAcc.of_Active_Ent_Technologies__c > 0  ){
                if(oldAccObj.Account_Type__c != 'Partner'){
                    tempAcc.Account_Type__c = 'Partner';
                    tempAcc.Registered_Partner__c = false;
                }
            }
            // End of Changes by Nimesh : NCR and Registered Checks for partners flowing in from MSI - 29/05 
        }
    }
  }
}