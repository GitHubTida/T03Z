trigger ZEBQuoteTrigger on Quote (after update){
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        Set<string> setOppId = new Set<string> ();
        Map<String,Integer> mapOppIdQuoteCount = new Map<String,Integer>();
        Set<string> setQuoteIds = new Set<String> ();
        List<opportunitylineitem> insertlstOppLineItem = new List<opportunitylineitem>();
        List<opportunitylineitem> updatelstOppLineItem = new List<opportunitylineitem>();
        List<id> opptyId = new List<Id>();
        Map<Id, Quote> quoteMap = new Map<Id, Quote>();
        for(Quote objquote : Trigger.new){
             Quote quoteOld = new Quote ();
             quoteMap.put(objquote.id,objquote); 
             quoteOld = Trigger.oldMap.get(objquote.ID);
             if((objquote.status == 'Approved'  && quoteOld.status != 'Approved') && (objquote.HasPrimary__c  == null || objquote.HasPrimary__c  == '')){
                 setQuoteIds.add(objquote.Id);
                 opptyId.add(objquote.OpportunityId);
            }
        }
        if(setQuoteIds.size() > 0){
            List<Quote_Line__c> lstQuotelineitem = [Select id,Price_Book_Entry_ID__c,Opportunity_Line_Item_ID__c,Cancel_flag__c, Unit_Special_Price__c,Max_Qty__c,Quote_Line_Item_Disti__r.pricebookentryId,Products__c, PC_Name__c from Quote_Line__c where PC_Name__c in :setQuoteIds ];
            List<ID> oppliID = new List<id>();
            for(Quote_Line__c qlc: lstQuotelineitem){
                if(qlc.Opportunity_Line_Item_ID__c != null)
                    oppliID.add(qlc.Opportunity_Line_Item_ID__c);
            }
            List<OpportunityLineItem> oliList = [Select id, hasschedule, OpportunityId,Opportunity.currencyIsoCode from Opportunitylineitem where id in :oppliID];
            Map<id,Boolean> mapOli = new Map<Id, Boolean>();
            for(OpportunityLineItem oli:OliList){
                mapOli.put(oli.id, oli.hasschedule);
            }
            Map<string,double> conversionMap = new Map<string,double>();
            Map<ID,String> OppCurrencyMap = new Map<ID,String>();
            
            for(CurrencyType CurCode : [select id,ConversionRate,IsoCode from CurrencyType])
                conversionMap.put(CurCode.IsoCode,CurCode.ConversionRate);
            for(Opportunity OppCurrency : [select id,CurrencyIsoCode from Opportunity where id =: opptyId])
                OppCurrencyMap.put(OppCurrency.id,OppCurrency.CurrencyIsoCode);
            for(Quote_Line__c objquotelineitem : lstQuotelineitem ){
                 if(objquotelineitem.cancel_flag__c != true && quoteMap.get(objquotelineitem.Pc_name__c) != null){
                    Opportunitylineitem objOppLineItem = new Opportunitylineitem();
                    objOppLineItem.OpportunityId = quoteMap.get(objquotelineitem.Pc_name__c).OpportunityId ;
                    objOppLineItem.Quote_Line_Item_ID__c = objquotelineitem.id;
                    objOppLineItem.Quantity = objquotelineitem.Max_Qty__c;
                    if(quoteMap.get(objquotelineitem.Pc_name__c).Direct_Account_Currency__c != 
                       OppCurrencyMap.get(quoteMap.get(objquotelineitem.Pc_name__c).OpportunityId)){
                        if(conversionMap.get(quoteMap.get(objquotelineitem.Pc_name__c).Direct_Account_Currency__c) != null){
                        double temp = objquotelineitem.Unit_Special_Price__c/conversionMap.get(quoteMap.get(objquotelineitem.Pc_name__c).Direct_Account_Currency__c);
                        objOppLineItem.UnitPrice = temp * conversionMap.get(OppCurrencyMap.get(quoteMap.get(objquotelineitem.Pc_name__c).OpportunityId));
                        }
                    }else{
                        objOppLineItem.UnitPrice = objquotelineitem.Unit_Special_Price__c;
                    }
                    if(objquotelineitem.Price_Book_Entry_ID__c != null)
                        objOppLineItem.pricebookentryId = objquotelineitem.Price_Book_Entry_ID__c;
                    objOppLineItem.AIT_PC__c = quoteMap.get(objquotelineitem.Pc_name__c).PC__c;
                    if(quoteMap.get(objquotelineitem.Pc_name__c).Primary__c && !quoteMap.get(objquotelineitem.Pc_name__c).ConvertedPC__c){
                        if(objquotelineitem.Opportunity_Line_Item_ID__c == null && objquotelineitem.Quote_Line_Item_Disti__c != null)
                            insertlstOppLineItem.add(objOppLineItem);
                        else{
                            if(mapOli.get(objquotelineitem.Opportunity_Line_Item_ID__c)!= null){
                                if(!mapOli.get(objquotelineitem.Opportunity_Line_Item_ID__c)){
                                    objOppLineItem.id  = objquotelineitem.Opportunity_Line_Item_ID__c;
                                    updatelstOppLineItem.add(objOppLineItem);   
                                }
                            }
                        }
                    }
                }
            }
            if(insertlstOppLineItem.size() > 0){
                system.debug('----insertlstOppLineItem-------->'+ insertlstOppLineItem);
                insert insertlstOppLineItem;
            }
            if(updatelstOppLineItem.size() > 0){
                system.debug('----updatelstOppLineItem-------->'+ updatelstOppLineItem);
                upsert updatelstOppLineItem;
            }
        }

    }    
}