/*******************************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika Mohanraj
Date        : 10-Oct-15
Description : The Purpose of this trigger is to create Opportunity Product based on Opportunity Product Families.
Revision History 
Ver       Date        Author             Modification 
---       ---------   -----------        -------------------------
V0.1      10-Oct-15   Ragamalika Mohanraj    Initial Code
********************************************************************************/

trigger DR_AddOpportunityProduct on Opportunity_Product_Families__c (before insert,  after Update) {
     
 List<Opportunity_Product_Families__c> opfList = new List<Opportunity_Product_Families__c>();
  DR_OpportunityProductTriggerHandler opporProduct = new DR_OpportunityProductTriggerHandler(); // initializing class
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
            If(OpptyProdFamily.Opportunity__c!=null && OppById.get(OpptyProdFamily.Opportunity__c)!=null){
                OpptyProdFamily.currencyisocode=OppById.get(OpptyProdFamily.Opportunity__c).currencyisocode;
                opfList.add(OpptyProdFamily);
            }
        }    
    } 
    
  if (Trigger.isAfter && Trigger.isUpdate){           
      List<Opportunity_Product_Families__c> oppProdFamily = [Select Id, Name, CurrencyIsoCode, Named_Product_Family__c, Named_Product_Family__r.Is_Service_Product__c, Opportunity__c, Quantity__c, Sales_Price__c, Source__c, Total_Price__c from Opportunity_Product_Families__c where Id in: Trigger.New];
        opporProduct.addOpportunityProduct(oppProdFamily); // add the product family to opportunity product
    }}