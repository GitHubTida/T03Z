trigger ZEBQuoteLineItemTrigger on QuoteLineItem (after insert,after update,before delete,before insert, before update ) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC Disti');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    
    List<QuoteLineItem> lstQuoteLineItem = new List<QuoteLineItem>();
    if(Trigger.isInsert || Trigger.isUpdate){
        for(QuoteLineItem objQuoteLineItem: trigger.new){
            lstQuoteLineItem.add(objQuoteLineItem);     
        }
    }
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate)
            ZEBTriggerQuoteLineItemHandler.UpdateQuotelineItemDistributor(lstQuoteLineItem);
    }
    
    if(Trigger.isInsert && Trigger.isAfter)
        ZEBTriggerQuoteLineItemHandler.insertQuoteLineItemReseller(lstQuoteLineItem);
    
    if(Trigger.isUpdate && Trigger.isAfter)
       ZEBTriggerQuoteLineItemHandler.updateQuoteLineItemReseller(lstQuoteLineItem);
    
    if(Trigger.isDelete){
        Set<Id> setQLTIds = new Set<Id>();
        Set<Id> pcIds = new Set<Id>();
        system.debug('Nimsi QLI --> '+ZEBUtility.IS_Reseller_Quote_LI_Deleted);
        if(!ZEBUtility.IS_Reseller_Quote_LI_Deleted){
        
            for(QuoteLineItem objQuoteLineItem: trigger.old){
                pcIds.add(objQuoteLineItem.QuoteId);
            }
            
            List<Quote> qi = [Select id, Status,Primary__c from Quote where id in :pcIds];
            Map<Id,String> qSta = new Map<Id,String>();
            Map<Id,Quote> grpQuote = new Map<Id,Quote>();
            set<id> oppProductLineDel = new set<id>(); // to delete
            for(Quote qi1:qi){
                qSta.put(qi1.id,qi1.Status);
                 // added on 14_12_2015 Manjunath C Sarashetti
                grpQuote.put(qi1.id,qi1);
            }
            for(QuoteLineItem objQuoteLineItem: trigger.old){
                if(qSta.get(objQuoteLineItem.QuoteId) == 'Pending' || qSta.get(objQuoteLineItem.QuoteId) == 'In Process' || qSta.get(objQuoteLineItem.QuoteId) == 'Rejected'){
                    system.debug('Nimsi');
                    system.debug('Nimsi--'+objQuoteLineItem.Opportunity_Line_Item_ID__c);
                   // added on 14_12_2015 Manjunath C Sarashetti
                   if(grpQuote.get(objQuoteLineItem.QuoteId).Primary__c == true && objQuoteLineItem.Opportunity_Line_Item_ID__c!=null && objQuoteLineItem.Opportunity_Line_Item_ID__c!=''  ){
                       id lineId = Id.valueOf(objQuoteLineItem.Opportunity_Line_Item_ID__c);
                       oppProductLineDel.add(lineId);
                   }
                    
                }
                else
                    //objQuoteLineItem.addError('Line Item cannot be deleted at this time');// changed as per Anna's request EVM CPQ - 23_12_2015
                    objQuoteLineItem.addError(Label.PC_Restrict_Line_Item_Deletion);
                setQLTIds.add(objQuoteLineItem.Id); 
            }
            ZEBTriggerQuoteLineItemHandler.deleteQuoteLineItemReseller(setQLTIds);
            
            try{
                List<OpportunityLineItem> oppLineId = new List<OpportunityLineItem>([Select id from OpportunityLineItem where id in :oppProductLineDel]);
                delete oppLineId;
            }catch(exception e){
                system.debug('--------Error while deleting the Line'+ e.getStackTraceString());
                 system.debug('--------Error while deleting the Line'+ e.getLineNumber());
            }
           // ZEBTriggerQuoteLineItemHandler.deleteChildLineItemDistributor(setQLTIds);
        } 
    }    
}
}