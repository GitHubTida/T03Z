/**************************************************************************************************
 * Name   : SSOUserTrigger 
 * Author : Dhruthi S, Mohammed Touseef Ahmed
 * Date   : 17-Nov-2015
 * Purpose: This trigger Performs the User actions when a new user is created.
 * ======================================
 * = MODIFICATION HISTORY =
 * ======================================
 * DATE            AUTHOR                   CHANGE
 * ----            ------                   ------
 * 17-Nov-2015     Dhruthi S               Created
 * 20-Nov-2015     Dhruthi S               Modified
 ***************************************************************************************************/
trigger SSOUserTrigger on User (after insert) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('User');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        Map<Id,Id> userAcctMap = new Map<Id,Id>();
        Map<Id,Id> userContMap = new Map<Id,Id>();
        for(User u : Trigger.New){
            if(u.IsPortalEnabled){
                userAcctMap.put(u.Id, u.AccountId);
                userContMap.put(u.ContactId,u.Id);
            }
        }
        if(userAcctMap.size() > 0 || userContMap.size()>0){
            SSOUserTriggerHandler.userActions(userAcctMap, userContMap);
        }
    }
}