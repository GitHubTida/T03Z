trigger ZEBOpportunity_bINS_bUPD on Opportunity (before insert, before update) {

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
    
    for(Opportunity oppTempVar : trigger.new){
        system.debug('---------ZEBOpportunity_bINS_bUPD ---->'+oppTempVar );
                system.debug('---------Owner_Theater__c ---->'+oppTempVar.Owner_Theater__c);
        oppTempVar.Opportunity_End_User__c = oppTempVar.AccountId ;
        
        //EVM CPQ changes
         if(oppTempVar.owner_theater__c=='APAC'){
                String fullFillmentType = oppTempVar.Fulfillment_Type__c;
                if(fullFillmentType == 'Direct to End User'  || fullFillmentType =='Distributor Sales In' || 
                                                            fullFillmentType == 'OEM Direct'){
                    oppTempVar.Direct_End_User__c = true;
                    oppTempVar.Direct_Distributor__c = false;
                    oppTempVar.Direct_Reseller__c = false;
                    }
                else if(fullFillmentType == 'Distributor Sales Out' || fullFillmentType == 'OEM Sales Out'){
                    oppTempVar.Direct_Distributor__c = true;
                    oppTempVar.Direct_End_User__c = false;
                     oppTempVar.Direct_Reseller__c = false;
                    
                    }
                else if(fullFillmentType == 'Direct to Partner'){
                
                    oppTempVar.Direct_Reseller__c = true;
                    oppTempVar.Direct_Distributor__c = false;
                    oppTempVar.Direct_End_User__c = false;
                    }
            
        }else{
            if(oppTempVar.Fulfillment_Type__c == 'Direct to End User'){
                oppTempVar.Direct_End_User__c = true;
                oppTempVar.Direct_Reseller__c = false;
                oppTempVar.Direct_Distributor__c = false;
             }else if(oppTempVar.Fulfillment_Type__c == 'Direct to Partner'){
                oppTempVar.Direct_Reseller__c = true;
                oppTempVar.Direct_End_User__c = false;
                oppTempVar.Direct_Distributor__c = false;
            }else if(oppTempVar.Fulfillment_Type__c == 'Distributor Sales Out'){
                oppTempVar.Direct_Distributor__c = true;
                oppTempVar.Direct_End_User__c = false;
                oppTempVar.Direct_Reseller__c = false;
            }else{
                oppTempVar.Direct_End_User__c = false;
                oppTempVar.Direct_Reseller__c = false;
                oppTempVar.Direct_Distributor__c = false;
            }
        }
        
        if(oppTempVar.Order_Date__c == null){
            oppTempVar.Order_Date__c  =oppTempVar.CloseDate;
        }
        
    }                           
}
}