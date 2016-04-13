/*
*
*  Written this to get the price book entry dor EVM data load only Delete afte the load
*Product2,Opp_Currency_Code__c,Opp_Price_book__c
*/

//List<PricebookEntry> pbeList = [SELECT Id, Product2Id, Name FROM PricebookEntry WHERE Name IN :skuNames and 
//currencyisocode = :opp.currencyisocode and Pricebook2Id = :opp.Pricebook2Id and product2.Product_Conversion_Source__c = 'EVM'];

trigger PCdataloadEVMOnly on QuoteLineItem (before insert) {

  If(TriggerDeactivateSwitch__c.GetAll().containsKey('Data Load Disti') && 
    TriggerDeactivateSwitch__c.GetAll().get('Data Load Disti').IsTriggerActive__c){
    set< string> uniquequote = new set<string>();
    set<id> productId = new set<id>();
    for(QuoteLineItem  oli:trigger.new){
        system.debug(oli.Product2id);
        system.debug(oli.Opp_Currency_Code__c);
        system.debug(oli.Opp_Price_book__c);
        //uniquequote.put(oli.Product2id+':'+oli.Opp_Currency_Code__c+':'+oli.Opp_Price_book__c,oli.Product2id+':'+oli.Opp_Currency_Code__c+':'+oli.Opp_Price_book__c)
        uniquequote.add(oli.Product2id+':'+oli.Opp_Currency_Code__c+':');
        productId.add(oli.Product2id);
        
    }
    system.debug('------------------uniquequote'+uniquequote);
    system.debug('------------------productId'+productId);
    List<PricebookEntry> pbeList =new List<PricebookEntry>([SELECT Id, Product2Id,PriceBook_Product__c,Pricebook2Id FROM PricebookEntry WHERE PriceBook_Product__c in :uniquequote and Pricebook2.Name in ('Zebra APAC RMB','Zebra APAC USD') and product2.Product_Conversion_Source__c = 'EVM' and IsActive=true and product2id in: productid]);
    
    Map<string, id> pbgrp = new Map<string,id>();
    for(PricebookEntry pbe:pbeList){
        pbgrp.put(pbe.PriceBook_Product__c+''+pbe.Pricebook2Id,pbe.id );
    }
    for(QuoteLineItem  oli:trigger.new){
        system.debug('------------------'+pbgrp);
        oli.PricebookEntryId = pbgrp.get(oli.Product2id+':'+oli.Opp_Currency_Code__c+':'+oli.Opp_Price_book__c);
        system.debug('------------------ sssPrice book'+oli.PricebookEntryId);
        system.debug('------------------ sss'+oli.Product2id+':'+oli.Opp_Currency_Code__c+':'+oli.Opp_Price_book__c);
    }
    
   } 
    
}