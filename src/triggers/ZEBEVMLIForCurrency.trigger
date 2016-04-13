/**************************************************************************************************
* Name   : ZEBUpdateOpportunityAsOnPartner
* Author : Priyanka_Singh33@infosys.com
* Date   : 25-Mar-2015 
* Purpose: This trigger is maps the currency of Opportunity to the EVM 
* 
* REVISION HISTORY 
* ======================================
* DATE              AUTHOR               CHANGE
* ----              ------               ------  
 25-Mar-2015        Priyanka Singh       Initial Code
***************************************************************************************************/

trigger ZEBEVMLIForCurrency on Price_Exception_Line_Item__c(before insert) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Price Exception');
    List<Price_Exception_Line_Item__c> peList = Trigger.new;
    List<ID> ids = new List<ID>();
    for(Price_Exception_Line_Item__c peli: Trigger.new){
        system.debug('Nimsi chk here --> '+peli.price_exception__c);
        ids.add(peli.price_exception__c);
    }
    List<Price_Exception__c> oppList = [Select id, currencyisocode from Price_Exception__c where id in :ids];
    Map<Id, String> currMap = new Map<ID, String>();

    for(Price_Exception__c pe: oppList){
        currMap.put(pe.id, pe.currencyisocode); 
    }
    system.debug('Nimsi map --> '+currMap);
    if(objTriggerDeactivate.IsTriggerActive__c){
        if(Trigger.isBefore){
            if(Trigger.isInsert){
                for (Price_Exception_Line_Item__c peli:Trigger.new){
                    system.debug('Nimsi -->'+peli.price_exception__c);
                    system.debug('Nimsi -->'+peli.currencyisocode);
                    system.debug('Nimsi -->'+currMap.get(peli.price_exception__c));
                    if(currMap.get(peli.price_exception__c) != peli.currencyisocode){
                        peli.currencyisocode = currMap.get(peli.price_exception__c);
                    }
                }
            } 
        }
    }
}