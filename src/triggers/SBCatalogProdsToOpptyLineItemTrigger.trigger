/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Priyanka_Singh33@infosys.com
    Date        : 02-Dec-15 
    Description : This class is written to sync solution builder to SFDC
    Revision History 
    Ver       Date        Author           Modification 
    ---       ---------   -----------      -------------------------
    V0.1      02-Dec-15   Priyanka Singh     Initial Code for storing products from SB Catalog Product to  
                                             Opportunity Products
***************************************************************/
trigger SBCatalogProdsToOpptyLineItemTrigger on SB_Catalog_Products__c(after insert, before insert){

SBCatalogProdsToOpptyLineItemHandler handlerRef =  new SBCatalogProdsToOpptyLineItemHandler();

handlerRef.insertSBProductToOli(Trigger.new);

/*if(Trigger.isInsert && Trigger.isBefore){
   handlerRef.insertProductNameFromOli(Trigger.new);
   }  */           
                   
  }