trigger ZEBQuoteReviseTrigger on Quote (before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        if(ZEBUtility.isNotZebraInterfaceUser()){
            List<String> lstQuoteId = new List<String>();  
            if(Trigger.isUpdate){  
                for(Quote objQuote : trigger.new){
                  Quote quoteOld = new Quote();
                  QuoteOld = Trigger.oldMap.get(objquote.ID);
                  if((QuoteOld.status == 'Approved' && QuoteOld.Revision__c < objQuote.Revision__c) || QuoteOld.status == 'Pending' )
                    lstQuoteId.add(objQuote.Id);                        
                }
                if(lstQuoteId.size() > 0){
                    List<Quote_Line__c> lQiR = [Select id,PC_Name__c,Cancel_Flag__c, Product_Line__c, Product_Category__c, Product_Family__c from Quote_line__C where Pc_name__C in :lstQuoteId];
                    if(lQiR.size()>0){
                        for(Quote objQuote : trigger.new){
                            objQuote.IsBarcodePdtLineExists__c = false ;
                            objQuote.isNaProductLine_Approval__c = false;
                            objQuote.isNaProductCategory_Approval__c = false;
                            objQuote.IsAftermarketServicesPdtLineExists__c = false;
                            objQuote.isLaProductCategory_Approval__c = false;
                            objQuote.IsCardPdtLineExists__c = false;
                            String QuotePriceList = objQuote.Account_Price_List__c ;
                            for(Quote_Line__c objQuoteLineReseller : lQiR){
                                if(objQuoteLineReseller.PC_Name__c == objQuote.Id && objQuoteLineReseller.Cancel_Flag__c == false){
                                    if(objQuoteLineReseller.Product_Line__c == 'Barcode Supplies'){
                                        objQuote.IsBarcodePdtLineExists__c = TRUE ;
                                        if(QuotePriceList == 'NA USD Price List' )
                                            objQuote.isNaProductLine_Approval__c = true;
                                    }
                                    if(objQuoteLineReseller.Product_Category__c == 'Aftermarket' && QuotePriceList == 'NA USD Price List')
                                        objQuote.isNaProductCategory_Approval__c = true;
                                    if(objQuoteLineReseller.Product_Category__c == 'Aftermarket' && QuotePriceList == 'LA USD Price List')
                                        objQuote.isLaProductCategory_Approval__c = true;
                                        
                                    if(objQuoteLineReseller.Product_Line__c == 'Aftermarket Services')
                                        objQuote.IsAftermarketServicesPdtLineExists__c = true;
                                       
                                     if((objQuoteLineReseller.Product_Line__c == 'Card' || objQuoteLineReseller.Product_Line__c == 'Card Supplies') || ((objQuoteLineReseller.Product_Line__c == 'Software and Peripherals' || objQuoteLineReseller.Product_Line__c == 'Aftermarket Products' || objQuoteLineReseller.Product_Line__c == 'Aftermarket Services')
                                                &&(objQuoteLineReseller.Product_Family__c == 'CPS Accessory' || objQuoteLineReseller.Product_Family__c == 'CPS Contract Service' || objQuoteLineReseller.Product_Family__c == 'CPS Parts' || objQuoteLineReseller.Product_Family__c == 'CPS Printheads' || objQuoteLineReseller.Product_Family__c == 'CPS Repair Service' || objQuoteLineReseller.Product_Family__c ==  'Card Software')))
                                       objQuote.IsCardPdtLineExists__c = true;
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}