trigger ZEBQuoteCalloutTrigger on Quote (before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
        Id EMEARecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC EMEA').getRecordTypeId();
        Id EMEAapprovedRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC EMEA Approved').getRecordTypeId();
        Id NARecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC NA').getRecordTypeId();
        Id NAapprovedRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC NA Approved').getRecordTypeId();
        Id APACRecordTypeId = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC APAC').getRecordTypeId();
        ID APACApprovedRecordTypeId= Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC APAC Approved').getRecordTypeId();
        if(ZEBUtility.isNotZebraInterfaceUser()){
            List<String> lstQuoteId = new List<String>();    
            if(Trigger.isUpdate){
                for(Quote objQuote : trigger.new){
                    Quote quoteOld = new quote ();
                    quoteOld = Trigger.oldMap.get(objquote.ID);
                    if(objQuote.is_Batch_Expired__c != true){
                        if((objQuote.Status == 'Approved' && quoteOld.status != 'Approved') || 
                           (objQuote.Status == 'Expired' && quoteOld.status != 'Expired') || 
                           (objQuote.Status == 'Cancelled' && quoteOld.status != 'Cancelled')){
                            if(objQuote.recordtypeid == EMEARecordTypeId)
                                objQuote.recordtypeid = EMEAapprovedRecordTypeId;   
                            else if(objQuote.recordtypeid == NARecordTypeId)
                                objQuote.recordtypeid = NAapprovedRecordTypeId; 
                            else if(objQuote.recordtypeid == APACRecordTypeId)
                                objQuote.recordtypeid = APACApprovedRecordTypeId;//
                            lstQuoteId.add(objQuote.Id);                        
                        }else if(objQuote.Status == 'In Process'){
                            if(objQuote.recordtypeid ==EMEAapprovedRecordTypeId)
                                objQuote.recordtypeid = EMEARecordTypeId;   
                            else if(objQuote.recordtypeid == NAapprovedRecordTypeId)
                                objQuote.recordtypeid = NARecordTypeId;  
                            else if(objQuote.recordtypeid == APACApprovedRecordTypeId)
                                objQuote.recordtypeid = APACRecordTypeId; //
                            if(quoteOld.Revision__c < objQuote.Revision__c ) {                     
                                lstQuoteId.add(objQuote.Id);
                            }
                        } 
                    }
                }
                if(lstQuoteId.size() > 0){
                    ZEBWebServiceCalloutFuture.getSFDCtoSiebelPriceConcessionFuture(lstQuoteId);
                }
            }
        }
    }
}