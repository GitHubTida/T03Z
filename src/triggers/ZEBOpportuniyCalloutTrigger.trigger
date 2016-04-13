trigger ZEBOpportuniyCalloutTrigger  on Opportunity (after insert, before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    Record_Type__c OpptyOpenRecordTypeId = Record_Type__c.getValues('Zebra Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
        if(ZEBUtility.isNotZebraInterfaceUser()){  
            list<string> lstOppIds = new list<string>();
            list<string> lstAccIds = new list<string>();
            list<string> lstOppNoSyncIds = new list<string>();
            list<OpportunityLineItem> lstOpportunityLineItem = new list<OpportunityLineItem>();
            for(Opportunity Oppty : trigger.new) {
                system.debug('Oppty.Account.AccountNumber ' +Oppty.Account.AccountNumber);
                if(Oppty.RecordTypeID == OpptyOpenRecordTypeId.Record_Type_Id__c){
                    lstAccIds.add(Oppty.AccountId);
                    lstOppIds.add(Oppty.Id);
                }
            }       
            system.debug('Nimsi: Check for account Sync'+lstAccIds);
            list<Account> lstAccount = [SELECT Account_Number__c,ZEB_Unique_Account_Number__c, SyncOppNonAITAcc__c , BillingCity ,BillingStreet ,Organization__c,currencyisocode,Currency_Code__c ,AccountNumber FROM Account WHERE id in: lstAccIds  and AccountNumber = null and Siebel_Row_Id__c = null and MSI_E_Account__c != null];   
            list<Account> lstAccountUpdated = new list<Account>();
            Boolean chkFlag = false;
              system.debug('ac:lstAccount ' +lstAccount);
            for(Account acc:lstAccount){
                acc.AccountNumber = acc.Account_Number__c;        
                acc.ZEB_Unique_Account_Number__c= acc.Account_Number__c;                  
                acc.SyncOppNonAITAcc__c = true;
                acc.Currency_Code__c = acc.currencyisocode;
                // Start - Nitin : Added condition to error out account creation in case billing city is not present
                if (acc.BillingCity == null){
                    system.debug('Please enter the city in the End User account for Account and Opportunity Sync');
                    chkFlag = true; 
                    break;
                }
                if (acc.BillingStreet == null) {
                    system.debug('Please enter the street in the End User account for Account and Opportunity Sync');
                    chkFlag = true;  
                    break;
                }
                system.debug('in here 2' + acc.BillingCountry );     
                system.debug('in here 2' + acc.BillingStatecode );     
                if (acc.BillingCountry == 'United States' && acc.BillingStatecode == null) {
                       system.debug('If Country is United States, then Billing State is required in the End User account for Account and Opportunity Synx');
                       chkFlag = true; 
                        break;
                }
                
               if(!chkFlag){ 
                    lstAccountUpdated.add(acc); 
               }
            }
            system.debug('Nimsi: Check for account Updated Sync'+lstAccountUpdated);

            if(lstAccountUpdated.size()>0){
                 ZEBUtility.inFutureCalloutContext = true;   
                update lstAccountUpdated;
                ZEBWebServiceCalloutFuture.getSFDCtoSiebelFutureEVM(lstAccIds, lstOppIds);
            }
            if(Trigger.isInsert) {
                for(Opportunity Oppty : trigger.new) {
                    if(Oppty.RecordTypeID == OpptyOpenRecordTypeId.Record_Type_Id__c)
                        lstOppIds.add(Oppty.Id);
                }       
                lstOpportunityLineItem = [Select Id From OpportunityLineItem where OpportunityId IN:lstOppIds];
                if(lstOpportunityLineItem.size()>0){  
                    if(lstOppIds.size()>0){
                        ZEBUtility.inOppFutureCalloutContext = true;
                        ZEBWebServiceCalloutFuture.getSFDCtoSiebelOpportuniyFuture(lstOppIds);
                    }
                }
            }
            if(Trigger.isupdate) {
                for(Opportunity Oppty : trigger.new) {
                    if(Oppty.RecordTypeID == OpptyOpenRecordTypeId.Record_Type_Id__c)
                        lstOppIds.add(Oppty.Id);
                }   
                system.debug('+++++++++++++++++'+ ZEBUtility.inOppFutureCalloutContext );
                
                system.debug('+++++++++++++++++'+ ZEBUtility.inOppFutureCalloutContext );
                lstOpportunityLineItem = [Select id,Name,OpportunityId,Product_Source__c From OpportunityLineItem where OpportunityId IN:lstOppIds];
                if(lstOpportunityLineItem.size()>0){
                    Map<Id,List<OpportunityLineItem>> oppProductMap = new Map<Id,List<OpportunityLineItem>>();
                    for(OpportunityLineItem oppLineItem1 : lstOpportunityLineItem){
                        if(oppProductMap.containskey(oppLineItem1.OpportunityId))
                            oppProductMap.get(oppLineItem1.OpportunityId ).add(oppLineItem1);
                        else
                            oppProductMap.put(oppLineItem1.OpportunityId ,new list<OpportunityLineItem>{oppLineItem1});
                    }
                    set<string> source= new Set<String>();  
                    for(Opportunity Opptys : trigger.new) {
                        if(oppProductMap.containskey(Opptys.id)){
                            for(OpportunityLineItem oppLineItem: oppProductMap.get(Opptys.id)){
                               Source.add(oppLineItem.Product_Source__c);
                            }
                            if(Source.contains('EVM')){
                                if(Source.contains('AIT')){
                                    Opptys.Product_Source__c='Both';
                                }else{
                                    Opptys.Product_Source__c='EVM';
                                }
                            }else if(Source.contains('AIT')){
                                Opptys.Product_Source__c='AIT';
                            }else {
                                 Opptys.Product_Source__c='';
                            }
                            Source.clear();
                        }
                        else{
                            Opptys.Product_Source__c='';
                        }
                    }
                    if(!ZEBUtility.inOppFutureCalloutContext){  
                        if(lstOppIds.size()>0)
                            ZEBWebServiceCalloutFuture.getSFDCtoSiebelOpportuniyFuture(lstOppIds);
                    }   
                }else{
                    for(Opportunity Opptys : trigger.new) {
                        Opptys.Product_Source__c='';    
                    }
                }
                /*lstOpportunityLineItem = [Select Id From OpportunityLineItem where OpportunityId IN:lstOppIds];
                if(lstOpportunityLineItem.size()>0){  
                    if(lstOppIds.size()>0){
                        ZEBWebServiceCalloutFuture.getSFDCtoSiebelOpportuniyFuture(lstOppIds);
                        system.debug('Inside Update');
                }
                }*/
            }
            
         }  
    } 
}