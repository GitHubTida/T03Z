/**************************************************************************************************
* Name   : SSOAccountTrigger
* Author : Dhruthi S
* Date   : 14-Jan-2016
* Purpose: This trigger is written to send all the contacts to sync in PING when an account or its PMI is updated.
* ======================================
* = MODIFICATION HISTORY =
* ======================================
* DATE            AUTHOR                   CHANGE
* ----            ------                   ------
* 14-Jan-2016     Dhruthi S               Created
***************************************************************************************************/
trigger SSOAccountTrigger on Account (after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Account');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        List<Id> accountChangedList = new List<Id>();
        List<Id> inactiveAccountList = new List<Id>();
        List<Id> activeAccountList = new List<Id>();
        List<Id> noResellerAccountList = new List<Id>();
        List<Id> noResellerButDistiAccountList = new List<Id>();
        List<Id> noDistiAccountList = new List<Id>();
        List<Id> noDistiButResellerAccountList = new List<Id>();
        List<Id> lostSolPartnerAccountList = new List<Id>();
        List<Id> gainSolPartnerAccountList = new List<Id>();
        List<Id> resellerAccountList = new List<Id>();
        List<Id> resellerWithDistiAccountList = new List<Id>();
        List<Id> distiAccountList = new List<Id>();
        List<Id> distiWithResellerAccountList = new List<Id>();
        
        for(Account acc : Trigger.New){
            if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c &&
               (acc.Name != Trigger.OldMap.get(acc.Id).Name || acc.AccountNumber != Trigger.OldMap.get(acc.Id).AccountNumber
               || acc.Partner_Region__c != Trigger.OldMap.get(acc.Id).Partner_Region__c || acc.Partner_Zone__c != Trigger.OldMap.get(acc.Id).Partner_Zone__c
               || acc.Partner_Program_Membership__c != Trigger.OldMap.get(acc.Id).Partner_Program_Membership__c
               || acc.Partner_Program_Product_Specialization__c != Trigger.OldMap.get(acc.Id).Partner_Program_Product_Specialization__c)){
                   system.debug('%Update SSO when account details are changed%');
                   accountChangedList.add(acc.Id);
            }
            if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c && acc.Partner_Status__c == 'Inactive' && acc.Partner_Status__c != Trigger.OldMap.get(acc.Id).Partner_Status__c ){
                system.debug('%Deactivate the contacts when the account becomes inactive%');
                inactiveAccountList.add(acc.Id);
            }
            if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c && acc.Partner_Status__c == 'Active' && acc.Partner_Status__c != Trigger.OldMap.get(acc.Id).Partner_Status__c ){
                system.debug('%Reactivate the contacts when the account becomes active%');
                activeAccountList.add(acc.Id);
            }
            if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c && acc.Partner_Status__c == 'Active' && acc.of_Active_Reseller__c == 0 && Trigger.OldMap.get(acc.Id).of_Active_Reseller__c > 0){
                if(acc.of_Active_Distributor__c == 0){
                    system.debug('%Remove the DR capabilities of the Contacts when Account loses reseller membership%');
                    noResellerAccountList.add(acc.Id);
                } else if(acc.of_Active_Distributor__c > 0){
                    system.debug('%Remove the DR reseller permission sets from Contacts when Account loses reseller membership but has distributor membership%');
                    noResellerButDistiAccountList.add(acc.Id);
                }
            }
            if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c && acc.Partner_Status__c == 'Active' && acc.of_Active_Distributor__c == 0 && Trigger.OldMap.get(acc.Id).of_Active_Distributor__c > 0){
                if(acc.of_Active_Reseller__c == 0){
                    system.debug('%Remove the DR capabilities of the Contacts when Account loses distributor membership%');
                    noDistiAccountList.add(acc.Id);
                } else if(acc.of_Active_Reseller__c > 0){
                    system.debug('%Remove the DR distributor permission sets from Contacts when Account loses distributor membership but has reseller membership%');
                    noDistiButResellerAccountList.add(acc.Id);
                }
            }
            if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c && acc.Partner_Status__c == 'Active' && acc.Partner_Region__c == 'NA' && acc.Partner_Program_Membership__c != null && Trigger.OldMap.get(acc.Id).Partner_Program_Membership__c.containsIgnoreCase('Solution Partner') && !acc.Partner_Program_Membership__c.containsIgnoreCase('Solution Partner')){
                system.debug('%Remove Solution Incentives permission set from Partner Users when partner loses the solution partner membership%');
                lostSolPartnerAccountList.add(acc.Id);
            }
            /*if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c && acc.Partner_Status__c == 'Active' && acc.Partner_Region__c == 'NA' && acc.Partner_Program_Membership__c != null && !Trigger.OldMap.get(acc.Id).Partner_Program_Membership__c.containsIgnoreCase('Solution Partner') && acc.Partner_Program_Membership__c.containsIgnoreCase('Solution Partner')){
                system.debug('%Assign Solution Incentives permission set to Partner Users when partner gains the solution partner membership%');
                gainSolPartnerAccountList.add(acc.Id);
            }*/
            if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c && acc.Partner_Status__c == 'Active' && acc.of_Active_Reseller__c > 0 && Trigger.OldMap.get(acc.Id).of_Active_Reseller__c == 0 && acc.Partner_Status__c == Trigger.OldMap.get(acc.Id).Partner_Status__c){
                if(acc.of_Active_Distributor__c == 0){
                    system.debug('%Assign the DR capabilities to the Contacts when Account gains reseller membership%');
                    resellerAccountList.add(acc.Id);
                } else if(acc.of_Active_Distributor__c > 0){
                    system.debug('%Assign DR reseller Permission Set to the users when Account gains reseller membership%');
                    resellerWithDistiAccountList.add(acc.Id);
                }
            }
            if(acc.Account_Type__c == 'Partner' && !acc.Is_ZISP__c && acc.Partner_Status__c == 'Active' && acc.of_Active_Distributor__c > 0 && Trigger.OldMap.get(acc.Id).of_Active_Distributor__c == 0 && acc.Partner_Status__c == Trigger.OldMap.get(acc.Id).Partner_Status__c){
                system.debug('%Assign the DR distributor capabilities to the Contacts when Account gains distributor membership%');
                if(acc.of_Active_Reseller__c == 0){
                    system.debug('%Assign the DR capabilities to the Contacts when Account gains distributor membership%');
                    distiAccountList.add(acc.Id);
                } else if(acc.of_Active_Reseller__c > 0){
                    system.debug('%Assign DR distributor Permission Set to the users when Account gains distributor membership%');
                    distiWithResellerAccountList.add(acc.Id);
                }
            }
        }
        
        if(accountChangedList != null && accountChangedList.size() > 0)
            SSOAccountTriggerHandler.updateSSOwithAccountDetails(accountChangedList);
        
        if(inactiveAccountList != null && inactiveAccountList.size() > 0)
            SSOAccountTriggerHandler.deactivateContactsOfInactiveAccount(inactiveAccountList);
        
        if(activeAccountList != null && activeAccountList.size() > 0)
            SSOAccountTriggerHandler.reactivateContactsOfActiveAccount(activeAccountList);
        
        if(noResellerAccountList != null && noResellerAccountList.size() > 0)
            SSOAccountTriggerHandler.removeDRwhenPartnerLosesMembership(noResellerAccountList);
        
        if(noDistiAccountList != null && noDistiAccountList.size() > 0)
            SSOAccountTriggerHandler.removeDRwhenPartnerLosesMembership(noDistiAccountList);
        
        if(noResellerButDistiAccountList != null && noResellerButDistiAccountList.size() > 0)
            SSOAccountTriggerHandler.partnerLosesPartialMembership(noResellerButDistiAccountList,'Reseller');
        
        if(noDistiButResellerAccountList != null && noDistiButResellerAccountList.size() > 0)
            SSOAccountTriggerHandler.partnerLosesPartialMembership(noDistiButResellerAccountList,'Distributor');
        
        if(lostSolPartnerAccountList != null && lostSolPartnerAccountList.size() > 0)
            SSOAccountTriggerHandler.partnerLostSolutionPartnerMem(lostSolPartnerAccountList);
        
        /*if(gainSolPartnerAccountList != null && gainSolPartnerAccountList.size() > 0)
            SSOAccountTriggerHandler.partnerGainSolutionPartnerMem(gainSolPartnerAccountList);*/
        
        if(resellerAccountList != null && resellerAccountList.size() > 0)
            SSOAccountTriggerHandler.reactivateContactsOfActiveAccount(resellerAccountList);
        
        if(distiAccountList != null && distiAccountList.size() > 0)
            SSOAccountTriggerHandler.reactivateContactsOfActiveAccount(distiAccountList);
        
        if(resellerWithDistiAccountList != null && resellerWithDistiAccountList.size() > 0)
            SSOAccountTriggerHandler.partnerGainReselOrDistiMem(resellerWithDistiAccountList);
        
        if(distiWithResellerAccountList != null && distiWithResellerAccountList.size() > 0)
            SSOAccountTriggerHandler.partnerGainReselOrDistiMem(distiWithResellerAccountList);
    }
}