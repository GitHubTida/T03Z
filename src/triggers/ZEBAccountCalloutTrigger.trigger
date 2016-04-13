trigger ZEBAccountCalloutTrigger on Account(after insert, before update, after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Account');
    System.debug('######'+objTriggerDeactivateSwitch.name);
    System.debug('++++++++++++'+objTriggerDeactivateSwitch.IsTriggerActive__c);
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        if(ZEBUtility.isNotZebraInterfaceUser()){
            list<string> lstAccIds = new list<string>();
            if(Trigger.isInsert){
                for(Account acc: trigger.new){
                    lstAccIds.add(acc.Id);   
                }
                list<Account> lstAccount = [SELECT recordtypeId,Account_Number__c,Account_Unique_Id__c ,AccountNumber,ZEB_Unique_Account_Number__c FROM Account WHERE id in: lstAccIds];   
                for(Account acc:lstAccount){
                    acc.AccountNumber = acc.Account_Number__c;
                    acc.Account_Unique_Id__c = acc.AccountNumber;
                    acc.ZEB_Unique_Account_Number__c= acc.Account_Number__c;
                }
                update lstAccount; 
            }
            if(Trigger.isupdate){
                if(Trigger.isAfter){
                    if(!ZEBUtility.inFutureCalloutContext){
                        for(Account acc: trigger.new) {
                            if(acc.accountnumber != null){ 
                                if(acc.Siebel_Row_Id__c != null){
                                    if(((acc.Name != Trigger.OldMap.get(acc.id).Name ) ||
                                        (acc.Translated_Name__c!= Trigger.OldMap.get(acc.id).Translated_Name__c)||
                                        (acc.Phone!= Trigger.OldMap.get(acc.id).Phone)||
                                        (acc.Fax != Trigger.OldMap.get(acc.id).Fax )||
                                        (acc.Tech_support_phone_number__c!= Trigger.OldMap.get(acc.id).Tech_support_phone_number__c)||
                                        (acc.CurrencyIsoCode!= Trigger.OldMap.get(acc.id).CurrencyIsoCode)||
                                        (acc.Price_List__c!= Trigger.OldMap.get(acc.id).Price_List__c)||
                                        (acc.billingstreet!= Trigger.OldMap.get(acc.id).billingstreet)||
                                        (acc.Billingcity!= Trigger.OldMap.get(acc.id).Billingcity)||
                                        (acc.billingStatecode!= Trigger.OldMap.get(acc.id).billingStatecode)||
                                        (acc.Billingcountry!= Trigger.OldMap.get(acc.id).Billingcountry)||
                                        (acc.Primary_County__c!= Trigger.OldMap.get(acc.id).Primary_County__c)||
                                        (acc.Account_Status__c!= Trigger.OldMap.get(acc.id).Account_Status__c)||
                                        (acc.Description!= Trigger.OldMap.get(acc.id).Description)||
                                        (acc.Organization__c!= Trigger.OldMap.get(acc.id).Organization__c)
                                        ))
                                    lstAccIds.add(acc.Id);
                                            
                                //}if(acc.Siebel_Row_Id__c == null && acc.AccountNumber == Trigger.OldMap.get(acc.id).AccountNumber && (acc.Address_Validation_Flag__c== Trigger.OldMap.get(acc.id).Address_Validation_Flag__c)){
                                //Removed the check on the Address_Validation_Flag__c as part of turning of Address Doctor
                                //}if(acc.Siebel_Row_Id__c == null && acc.AccountNumber == Trigger.OldMap.get(acc.id).AccountNumber){
                                //}if(acc.Siebel_Row_Id__c == null && acc.AccountNumber == Trigger.OldMap.get(acc.id).AccountNumber && ((acc.recordtypeId == Trigger.OldMap.get(acc.id).recordtypeId ))){
                                //}if(acc.Siebel_Row_Id__c == null && acc.AccountNumber == Trigger.OldMap.get(acc.id).AccountNumber){
                                //}if(acc.Siebel_Row_Id__c == null && acc.AccountNumber != Trigger.OldMap.get(acc.id).AccountNumber && Trigger.OldMap.get(acc.id).AccountNumber == Null){
                                }if(acc.Siebel_Row_Id__c == null && acc.AccountNumber == Trigger.OldMap.get(acc.id).AccountNumber){
                                    lstAccIds.add(acc.Id);
                                }
                            }
                            system.debug('@@@@@ Account After Update Old Map'+Trigger.OldMap);
                            system.debug('@@@@@ Account After Update New Map'+Trigger.NewMap);
                        }
                        if(lstAccIds.size() > 0){
                            ZEBWebServiceCalloutFuture.getSFDCtoSiebelFuture(lstAccIds);
                        }
                    }
                }/*
                else if(Trigger.isBefore){
                    for(Account acc: trigger.new) { 
                        acc.SFDCSiebel_Sync_Status__c = false;
                        acc.BO_Synch_Status__c = null;
                        acc.BO_Error__c = null ;
                    }               
                }*/
            }  
        }
        /*if(!ZEBUtility.isNotZebraInterfaceUser()){
           list<string> lstAccIds = new list<string>();
            if(Trigger.isInsert){
                for(Account acc: trigger.new){
                    lstAccIds.add(acc.Id);   
                }
                list<Account> lstAccount = [SELECT Account_Number__c,Account_Unique_Id__c ,AccountNumber,ZEB_Unique_Account_Number__c FROM Account WHERE id in: lstAccIds and AccountNumber =null and ZEB_Unique_Account_Number__c!= null];   
                for(Account acc:lstAccount){
                    acc.AccountNumber = acc.ZEB_Unique_Account_Number__c;
                }
            update lstAccount; 
            }
        }*/ 
     }
    // Workflow Field Updated are moved into Before Update Trigger
    if(Trigger.isBefore && Trigger.isupdate){
        for(Account acc: trigger.new) { 
            if(acc.Account_Type__c == 'End User' && acc.Financial_Customer_Flag__c == false  ){
              acc.recordTypeId =Record_Type__c.getValues('End User Accounts').Record_Type_Id__c; 
            }
            if(acc.Account_Type__c == 'End User' && acc.Financial_Customer_Flag__c == true  ){
              acc.recordTypeId =Record_Type__c.getValues('Financial End User Accounts').Record_Type_Id__c; 
            }
            if(acc.Account_Type__c == 'Non Classified Reseller' && acc.Financial_Customer_Flag__c == true  ){
               acc.recordTypeId =Record_Type__c.getValues('Financial Non-Classified Resellers').Record_Type_Id__c; 
            }
            if(acc.Account_Type__c == 'Partner' && acc.Financial_Customer_Flag__c == true  ){
                acc.recordTypeId =Record_Type__c.getValues('Financial Partners').Record_Type_Id__c; 
            }
            if(acc.Account_Type__c == 'Non Classified Reseller' && acc.Financial_Customer_Flag__c == false  ){
                acc.recordTypeId =Record_Type__c.getValues('Non-Classified Resellers').Record_Type_Id__c; 
            }
            if(acc.Account_Type__c == 'Partner' && acc.Financial_Customer_Flag__c == false  ){
                acc.recordTypeId =Record_Type__c.getValues('Partners').Record_Type_Id__c; 
            }
            if(acc.Account_Type__c == 'Prospect' && acc.Financial_Customer_Flag__c == false  ){
                acc.recordTypeId =Record_Type__c.getValues('Prospect').Record_Type_Id__c; 
            }
            if(acc.of_Active_Distributor__c > 0){
                acc.Distributor__c = true; // Distributor Flag on Account
            }
            if(acc.of_Active_Distributor__c == 0){
                acc.Distributor__c = false; // Uncheck Distributor Flag on Account
            }  
        }               
    }// Workflow Field Updated are moved into Before Update Trigger
   
}