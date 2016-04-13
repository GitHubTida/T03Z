trigger ZEBQuoteSendEmailToOpportunityTeam on Quote (after update){
 TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
    List<Quote> allQuotes = new List<Quote>();
    List<ID> approvedQtID= new List<ID>();
    
    if(Trigger.isUpdate){
        for(Quote objQuote : trigger.new){
            Quote quoteOld = Trigger.oldMap.get(objquote.ID);
            if(QuoteOld.status != 'Approved' && objQuote.Status=='Approved'){
                allQuotes.add(objQuote);    
                approvedQtID.add(objQuote.ID);           
            } 
        }
    }
         if(allQuotes != null && allQuotes.size() > 0){
         ZEBEmailHandler instPCEmailHandler = new  ZEBEmailHandler ();
         instPCEmailHandler.sendFinalMail(allQuotes,approvedQtID);
        }
      }
}