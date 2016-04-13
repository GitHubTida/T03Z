trigger ZEBPCAutoNumberCalculationAddCompetitor on Quote (before insert, after insert,after update){
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c){
        if(trigger.isUpdate){
            Map<string,string> mapQuoteIdOppOwnerId = new Map<string,string>();
            Set<Id> QuoteIds = trigger.newmap.keyset();
            for(quote objquote: [SELECT Id, Opportunity.ownerId FROM Quote where id in :QuoteIds ])
                mapQuoteIdOppOwnerId.put(objquote.id,objquote.Opportunity.ownerId);
            system.debug('-------------mapQuoteIdOppOwnerId---------------->'+mapQuoteIdOppOwnerId);
            for(Quote objQuote : trigger.new){
                Quote oldQuote = Trigger.OldMap.get(objQuote.Id);
                if(objQuote.isReadyForApproval__c == TRUE && oldQuote.isReadyForApproval__c == FALSE) {
                    try{
                        Approval.ProcessSubmitRequest submitRequest = new Approval.ProcessSubmitRequest();
                        submitRequest.setObjectId(objQuote.Id);
                        // 2_4_2016 as it was going for opp owner as submitter
                        if(objQuote.PC_Opp_Owner_Theater__c !=null && objQuote.PC_Opp_Owner_Theater__c.trim()=='EMEA' && objQuote.PC_Submitter__c!=null ){
                            submitRequest.setSubmitterId(objQuote.PC_Submitter__c);
                            System.debug('=================>Test 1');
                        }
                        else{
                           submitRequest.setSubmitterId(mapQuoteIdOppOwnerId.get(objQuote.Id));
                            System.debug('=================>Test 2');
                        }
                        //submitRequest.setSubmitterId(mapQuoteIdOppOwnerId.get(objQuote.Id));
                        Approval.ProcessResult result = Approval.process(submitRequest);
                   }catch(Exception e){
                       system.debug('No Approval process found');
                   }
                }
            }
        }
        if(Trigger.IsInsert && Trigger.isAfter){
            list<Quote> lstQuote = new list<Quote>();
            for(Quote objQuote : trigger.new){
                lstQuote.add(objQuote);
            }
            ZEBTriggerQuoteLineItemHandler.InsertQuoteCompetitors(lstQuote);
        }   
        if(trigger.isInsert && Trigger.isBefore){
            Map<string,integer> maprecIdCount = new map<string,integer>();
            Integer siNo;
            AggregateResult[] groupedResults = [SELECT max(PC__c) FROM quote];
            for (AggregateResult ar : groupedResults){
                maprecIdCount.put('PCNUM',integer.valueof(ar.get('expr0')));
            }
            for(Quote objQuote : trigger.new){
                if(maprecIdCount.get('PCNUM') != null){
                    siNo  = maprecIdCount.get('PCNUM')+1;
                }else{
                    siNo  = 8000001;
                }
                objQuote.PC__c = string.valueOf(siNo);
                objQuote.PC_NumberFormat__c = siNo;
                objQuote.Name=objQuote.PC__c+' : '+ objQuote.Name;
                maprecIdCount.put('PCNUM', siNo );
            }
        }
    }
}