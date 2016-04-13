/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Vishal_Jujaray@infosys.com
Date        : 25-Mar-15 
Description : This trigger is written to add Product family to Opportunity Product Family using trigger handler class.
Revision History 
Ver       Date        Author           Modification 
---       ---------   -----------      -------------------------
V0.1      25-Mar-15   Priyanka Singh   Initial Code
V0.2      11-Aug-15   Kushal Soni      Replaced Trigger.New with the List of Opportunity Product Family with the required fields
***************************************************************/

trigger ZEBaddOpportunityProduct on Opportunity_Product_Families__c (before insert,  after insert) {

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
    
 
 List<Opportunity_Product_Families__c> opfList = new List<Opportunity_Product_Families__c>();
 ZEBOpportunityProductTriggerHandler opporProduct = new ZEBOpportunityProductTriggerHandler(); // initializing class
    Set<Id> OppIds=new Set<Id>();
    if (Trigger.isBefore && Trigger.isInsert){
        for (Opportunity_Product_Families__c OpptyProdFamily: Trigger.new)
            OppIds.add(OpptyProdFamily.Opportunity__c);
        List<Opportunity> OpptyRec=[select id, currencyisocode from Opportunity where id in :OppIds];   
        system.debug('OppIds --> '+OppIds);
        Map<Id, Opportunity> OppById=new Map<Id, Opportunity>();
        OppById.putall(OpptyRec);
         system.debug('OppById --> '+OppById);
        for (Opportunity_Product_Families__c OpptyProdFamily : Trigger.new)
        {
            OpptyProdFamily.currencyisocode=OppById.get(OpptyProdFamily.Opportunity__c).currencyisocode;
            opfList.add(OpptyProdFamily);
        }    
    } 
    
    if (Trigger.isAfter && Trigger.isInsert){
      
      // Below list added by Kushal in place of Trigger.new with the required fields.
      List<Opportunity_Product_Families__c> oppProdFamily = [Select Id, Name, CurrencyIsoCode, Named_Product_Family__c, Named_Product_Family__r.Is_Service_Product__c, Opportunity__c, Quantity__c, Sales_Price__c, Source__c, Total_Price__c from Opportunity_Product_Families__c where Id in: Trigger.New];
        opporProduct.addOpportunityProduct(oppProdFamily); // add the product family to opportunity product
    }
}}