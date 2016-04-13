/*******************************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Shanthi Latharani
Date        : 22-Sep-15
Description : This Trigger is used by Deal Registration Object to call the DealRegistrationHandler class based on the action.

Revision History
Ver       Date        Author             Modification
---       ---------   -----------        -------------------------
V0.1      22-Sep-15   Shanthi Latharani    Initial Code
 ********************************************************************************/

trigger Trig_DealRegistration on Deal_Registration__c (before insert,before update,after insert,after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Deal Registration');
    List<Id> extensionRequestIdList = new List<Id>();
    if(ZEBUtility.isNotZebraInterfaceUser()) {
        if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
            List<Deal_Registration__c> drList = new List<Deal_Registration__c>();
            for(Deal_Registration__c dr : Trigger.new){
                if(dr.Opportunity_Stage__c == null || (dr.Opportunity_Stage__c != null && !dr.Opportunity_Stage__c.containsIgnoreCase('Closed')))
                    drList.add(dr);
                /*if(Trigger.isUpdate && Trigger.isAfter){
                    if(dr.Extension_Status__c=='Requested' && (Trigger.oldMap.get(dr.Id).Extension_Status__c != Trigger.newMap.get(dr.Id).Extension_Status__c))
                        extensionRequestIdList.add(dr.Id);
                }*/
            }
            if(drList.size() > 0){
                if(Trigger.isInsert && Trigger.isBefore){
                    DealRegistrationTriggerHandler.DealRegistrationFieldUpdateHandler(drList);
                }
                if(Trigger.isUpdate && Trigger.isBefore){
                    DealRegistrationTriggerHandler.DealRegistrationApproverErrorMsgHandler(drList);
                    DealRegistrationTriggerHandler.DealRegistrationapprovalprocessupdate(drList);
                    DealRegistrationTriggerHandler.DealRegistrationSolutionDiscountFieldUpdateHandler(drList);
                }
                if( Trigger.isAfter && Trigger.isUpdate){
                    system.debug('drList size is '+drList.size());
                    system.debug('drList'+drList);
                    DealRegistrationTriggerHandler.DealRegistrationSharingToApproverHandler(drList);
                }
            }
            if(Trigger.isUpdate && Trigger.isAfter){
                DealRegistrationTriggerHandler.DealRegistrationToOpportunityAutomatorHandler(Trigger.old,Trigger.new,Trigger.oldMap,Trigger.newMap);
                /*if(extensionRequestIdList.size() > 0){
                    extensionRequestIdList.clear();
                    DealRegistrationTriggerHandler.newTaskCreation(Trigger.new);
                }*/
            }
        }
    }
}