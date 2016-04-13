/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Nikhil Kumar
    EMAIL       : Nikhil_Kumar19@Infosys.com
    Date        : 05-JAN-15
    Revision History
    Ver       Date        Author            Modification
    ---       ---------   -----------       -------------------------
    V0.1      05-JAN-15   Nikhil Kumar         Initial Code  
 ***************************************************************/



trigger PCUpdateCurrecyConvertion on Quote_Line__c(Before insert,Before update) {
   
    If(TriggerDeactivateSwitch__c.GetAll().containsKey('Data Load Reseller') && 
    TriggerDeactivateSwitch__c.GetAll().get('Data Load Reseller').IsTriggerActive__c){
    
        // Map of Currency Code
        Map<String,CurrencyType> currencyTable = new Map<String,CurrencyType>();
        
        For(CurrencyType cur: [Select ConversionRate,IsoCode,DecimalPlaces from CurrencyType WHERE IsActive=True]){
             currencyTable.put(cur.IsoCode,cur);
        } 
        
        //Id For Quote records
        Set<id> QuoteIds = New Set<id>();
        
        For(Quote_Line__c  QL: Trigger.New){
        
            If(QL.PC_Name__c!=Null)
                QuoteIds.Add(QL.PC_Name__c);
             
        }
        
        //Map of Quote records
        Map<Id,Quote> QuoteRecs = New Map<id,Quote>([Select id,CurrencyIsocode,Direct_Account_Currency__c From Quote Where ID IN :QuoteIds]);
        
        For(Quote_Line__c  QL: Trigger.New){
       
           if(QL.PC_Name__c!=Null && QuoteRecs.ContainsKey(QL.PC_Name__c) && QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode!=Null && 
           QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c!=Null &&QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode!=QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c){
           
               If(QL.List_Price__c!=Null){
               
                   QL.List_Price__c=((QL.List_Price__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate)*currencyTable.get(QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c).ConversionRate);
               }
               If(QL.Standard_Net_Price__c!=Null){
               
                   //QL.Standard_Net_Price__c=((QL.Standard_Net_Price__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate)*currencyTable.get(QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c).ConversionRate);
                   QL.Standard_Net_Price__c=QL.Standard_Net_Price__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate;
               }
               If(QL.Total_Cost__c!=Null){
               
                   QL.Total_Cost__c=((QL.Total_Cost__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate)*currencyTable.get(QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c).ConversionRate);
               }
               If(QL.Total_Net_Price__c!=Null){
               
                   QL.Total_Net_Price__c=((QL.Total_Net_Price__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate)*currencyTable.get(QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c).ConversionRate);
               }
               If(QL.Total_PC_Cost__c!=Null){
               
                   QL.Total_PC_Cost__c=((QL.Total_PC_Cost__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate)*currencyTable.get(QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c).ConversionRate);
             }
               If(QL.Unit_Special_Price__c!=Null){
               
                   QL.Unit_Special_Price__c=((QL.Unit_Special_Price__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate)*currencyTable.get(QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c).ConversionRate);
               }
               If(QL.Net_Price__c!=Null){
               
                   QL.Net_Price__c=((QL.Net_Price__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate)*currencyTable.get(QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c).ConversionRate);
                  
               }
               if(QL.PC_Price__c!=null){
                  QL.PC_Price__c=((QL.PC_Price__c/currencyTable.get(QuoteRecs.get(QL.PC_Name__c).CurrencyIsoCode).ConversionRate)*currencyTable.get(QuoteRecs.get(QL.PC_Name__c).Direct_Account_Currency__c).ConversionRate);
               }
           }
        }
   } 
}