/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Dhruthi_S@infosys.com
Date        : 09-Mar-15 
Description : This trigger is written to Provide the ID of corresponding PriceBook based on Owners Organization.
Revision History 
This trigger is written to populate the exchange rate of the Opportunity Amount 
Ver       Date        Author           Modification 
---       ---------   -----------      -------------------------
V0.1      09-Mar-15   Dhruthi S      Initial Code
V0.2      30-Mar-15   Vishal R       Included the Currency Exchange rate functionality
V0.3      29-Apr-15   Dhruthi S      Replaced PriceBook Ids with custom setting
***************************************************************/

trigger ZEBSetDefaultPriceBook on Opportunity(before insert, before update){

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
    
    system.debug('UserInfo.getUserId() '+UserInfo.getUserId() );
  //if(UserInfo.getUserId() != '005i00000038SYNAA2'){
  
    
    List<ID> ownerIds = new List<ID>();
    List<String> CurrencyISOCodeList = new List<String>();
    for(Opportunity o : trigger.new){
        ownerIds.add(o.ownerid);
        CurrencyISOCodeList.add(o.CurrencyISOCode);
    }
    Map<ID, String> orgMap = new Map<ID, String>();
    
    //Using Custom Setting to avoid hardcoding of PriceBook IDs
    PriceBook__c zebraNALA = PriceBook__c.getValues('Zebra NALA');
    PriceBook__c zebraEMEA = PriceBook__c.getValues('Zebra EMEA');
    PriceBook__c zebraAPACusd = PriceBook__c.getValues('Zebra APAC USD');
    PriceBook__c zebraAPACrmb = PriceBook__c.getValues('Zebra APAC RMB');
    PriceBook__c stdPriceBook = PriceBook__c.getValues('Standard Price Book');
    
    Map<String, String> someCustomSettings = new Map<String, String>();
    
    if(zebraNALA.Price_Book_ID__c != null)
        someCustomSettings.put('Zebra NALA', zebraNALA.Price_Book_ID__c);
    if(zebraEMEA.Price_Book_ID__c != null)
    someCustomSettings.put('Zebra EMEA', zebraEMEA.Price_Book_ID__c);
if(zebraAPACusd.Price_Book_ID__c != null)
    someCustomSettings.put('Zebra APAC USD', zebraAPACusd.Price_Book_ID__c);
if(zebraAPACrmb.Price_Book_ID__c != null)
    someCustomSettings.put('Zebra APAC RMB', zebraAPACrmb.Price_Book_ID__c);
if(stdPriceBook.Price_Book_ID__c != null)
    someCustomSettings.put('Default Organization', stdPriceBook.Price_Book_ID__c);
    
    /*someCustomSettings.put('Zebra NALA', '01se00000009tQo');
    someCustomSettings.put('Zebra EMEA', '01se00000009tQt');
    someCustomSettings.put('Zebra APAC USD','01se00000009tQy');
    someCustomSettings.put('Zebra APAC RMB', '01se00000009tgI');
    someCustomSettings.put('Default Organization','01si0000000IiPc');*/
    
    List<User> userList = [Select Id, Zebra_Organization__c from user where id = :ownerIds];
    List<CurrencyType> CurrencyTypeList = [Select Id, ISOCode,ConversionRate from CurrencyType where ISOCode = :CurrencyISOCodeList limit 1];
    
    for (User u:userList){
            orgMap.put(u.id, u.Zebra_Organization__c );
    }
    for(Opportunity o : trigger.new){
        if(o.Pricebook2Id == null){
            if(orgMap.get(o.Ownerid) != null){
                //Provide the ID of corresponding PriceBook based on Owners Region or Organization;
                //if(o.currencyisocode != 'CNY')
                if(orgMap.get(o.Ownerid) != 'Zebra APAC RMB')
                    o.Pricebook2Id = someCustomSettings.get(orgMap.get(o.Ownerid));
                else
                    o.Pricebook2Id  =someCustomSettings.get('Zebra APAC RMB');   
            }
            
        }
        //Added the Exchange rate functionality
        if(CurrencyTypeList[0].ConversionRate != null){
            o.FX_Rate__c = CurrencyTypeList[0].ConversionRate;
         }
            
        }
   //}     
}

}