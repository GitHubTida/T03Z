trigger ZEBLoadApprovalsFromMapping on Quote (before insert,before update){
TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
 //if(TriggerDeactivateSwitch__c.getAll().Containskey('PC') && 
            //TriggerDeactivateSwitch__c.getAll().get('PC').IsTriggerActive__c)
            if(objTriggerDeactivateSwitch.IsTriggerActive__c){
    List<Quote> allQuotes = new List<Quote>();
    if(Trigger.isInsert || Trigger.isUpdate){
         for(Quote objQuote : trigger.new){
            allQuotes.add(objQuote);  
         }   
    }
    if(Trigger.isUpdate){
        for(Quote objQuote : trigger.new){
            Quote quoteOld = new Quote();
            QuoteOld = Trigger.oldMap.get(objquote.ID);
            if((QuoteOld.status == 'Approved' && QuoteOld.Revision__c < objQuote.Revision__c) || QuoteOld.status == 'Pending' )
                allQuotes.add(objQuote);                        
        }
    }
    if(allQuotes != null && allQuotes.size() > 0){
        ZEBQuoteHandler instPCQuoteHandler = new ZEBQuoteHandler();
        instPCQuoteHandler.QuoteApprover(allQuotes);
    }
   }
}