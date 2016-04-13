/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika_m@infosys.com
Date        : 29-Apr-15 
Description : This trigger is written to grant Read/Write access to Opportunity Owner for GSS
Ver       Date        Author                   Modification 
---       ---------   -----------              -------------------------
V0.1      29-Apr-15   Ragamalika Mohanraj      Initial Code
***************************************************************/

trigger ZEBServiceSharingOnOwnerChange on Opportunity (after update) {

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
try{
        List<Opportunity> opportunityList = new List<Opportunity>();
        List<Id> oppId = new List<Id>();
        List<Id> deleteShare = new List<Id>();
        Map<Id,Id> ownerIdMap = new Map<Id,Id>();
        for(Opportunity opp : trigger.new){
            Opportunity oldOpp = Trigger.oldMap.get(opp.ID);
            if(oldOpp.OwnerId != opp.OwnerId){
                opportunityList.add(opp); 
                ownerIdMap.put(opp.Id,opp.OwnerId);
                
            }
        }
        List<Custom_Services__c> serviceList =new List<Custom_Services__c>([SELECT Id,OwnerId,Opportunity__r.Id FROM Custom_Services__c WHERE Opportunity__c IN : opportunityList]);
        Map<Id,List<Custom_Services__c>> oppServiceMap = new Map<Id,List<Custom_Services__c>>();
        for(Custom_Services__c service : serviceList){
            if(oppServiceMap.containsKey(service.Opportunity__r.Id))
                oppServiceMap.get(service.Opportunity__r.Id).add(service);
            else
                oppServiceMap.put(service.Opportunity__r.Id,new List<Custom_Services__c>{service});
        }
        // Null check loop Starts
        if(!oppServiceMap.isEmpty()){
           
            
            List<Custom_Services__Share> ServiceShareList = new List<Custom_Services__Share>();
             List<Custom_Services__c> allSolutionServiceList = new  List<Custom_Services__c>();
                  
            for(Opportunity oppServiceShare : opportunityList){
            allSolutionServiceList.addAll(oppServiceMap.get(oppServiceShare.Id));
            }
           
                for(Custom_Services__c serviceShare : allSolutionServiceList){
                deleteShare.add(serviceShare.Id);
                    if(ownerIdMap.get(serviceShare.Opportunity__c) <> serviceShare.OwnerId){
                        Custom_Services__Share SolutionsAndServicesShare = new Custom_Services__Share();
                        SolutionsAndServicesShare.ParentId = serviceShare.Id;
                        SolutionsAndServicesShare.UserOrGroupId = ownerIdMap.get(serviceShare.Opportunity__c);
                        SolutionsAndServicesShare.AccessLevel = 'Edit';
                        ServiceShareList.add(SolutionsAndServicesShare);
                    }
                }
          
           //deleting old sharing from old opportunity owner
           
           if (!deleteShare.isEmpty()){
                List<Custom_Services__Share> listDeleteShare = new List<Custom_Services__Share>([select id from Custom_Services__Share where ParentId IN : deleteShare AND RowCause = 'Manual']);
                delete listDeleteShare;
                }
            // adding new sharing rule to new owner
            Database.SaveResult[] ServiceShareInsertResult = Database.insert(ServiceShareList,false);
        }
        // Null check loop Ends
        
 }
 
 catch(Exception e)
        {
            System.debug('Validation Message : '+e.getMessage());
        }
    }
}