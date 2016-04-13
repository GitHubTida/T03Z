/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : 
Date        : 12-Aug-2015
Description :  

--------------------------------------------------------------------------------
MODIFICATION HISTORY
 
MODIFICATION DATE   MODIFIED BY             REASON
12-Aug-2015         Prabhata Rath             initial code
-------------------------------------------------------------------------------- 
***************************************************************/

trigger DD_LimitAlternativeAddress on DD_Address__c (Before Insert) {

    if(TriggerDeactivateSwitch__c.getAll().Containskey('Address') && 
            TriggerDeactivateSwitch__c.getAll().get('Address').IsTriggerActive__c){
       
    List<DD_Address__c> lst_newAltAdrs = trigger.new;
    Set<String> set_User = new Set<String>();
    
    For(DD_Address__c address : lst_newAltAdrs) {
        set_User.add(address.User__c);
    }
    
    list<AggregateResult> results = [Select User__c,COUNT(Id) cnt from DD_Address__c where recordType.developerName='Alternative_Address' and User__c IN :set_User GROUP BY User__c];
    
    for(DD_Address__c addRecord : lst_newAltAdrs){
        For(AggregateResult res : results){
            string userName = (string)res.get('User__c');
            Integer count1 = (Integer)res.get('cnt'); 
            if(addRecord.User__c == userName){
                if(count1 < 10)
                    System.debug('New Alternate Address Inserted');
                else
                    addRecord.addError('Maximum Limit reached. To store this address, please delete one of the existing alternative address');
            }
        }
    }
    }
}