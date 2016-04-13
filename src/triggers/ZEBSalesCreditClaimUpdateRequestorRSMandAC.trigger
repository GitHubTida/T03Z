/**************************************************************
*    Copyright © 2015 Zebra Technologies. All rights reserved.
*    Author          : Nitin Shivshankara
*    Date            : 6/10/2015
*    Description     : This trigger does the following operations:
*                      1. Updates Region
*                      2. Updates Request Manager
*                      3. Updates RSM
*                      4. Updates Region Controller
*    Revision History:
*    Ver       Date              Author                     Modification
*    ----      ---------         -----------                --------------------
*    1.0       6/10/2015       Nitin Shivashankara        Initial Creation with all the requirements
*********************************************************************************/

trigger ZEBSalesCreditClaimUpdateRequestorRSMandAC on Sales_Credit_Claim__C(before insert, before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Sales Credit Claim');
    if(objTriggerDeactivate.IsTriggerActive__c){
    //holds User Ids
    Set<String> userIdSet = new Set<String>();
    //holds a list of Users
    List<User> userList = new List<User>();
    List<User> managerUserList = new List<User>();
    //holds key value pairs of User Id and User Object
    Map<Id, String> managerEmailMap = new Map<Id, String>();
    Map<Id, Id> managerMap = new Map<Id, Id>();
    Map<Id, Id> areaControllerMap = new Map<Id, Id>();
    Map<Id, String> userTheaterMap = new Map<Id, String>();
    Map<Id, User> userMap = new Map<Id, User>();
    Map<String, FieldOperationsTeam__c> fieldOpsMap = FieldOperationsTeam__c.getAll();
    for (String fOp : fieldOpsMap.keySet()) {
        userIdSet.add(fieldOpsMap.get(fOp).Approver_User_Id__c);
    }
    //For each Sales_Credit_Claim__C being inserted add User Id value in in Set of User Ids.
    for (Sales_Credit_Claim__C oppObj : Trigger.new) {
        if (oppObj.OwnerId != null)
            userIdSet.add(oppObj.OwnerId);
        if (oppObj.Requestor__c != null)
            userIdSet.add(oppObj.Requestor__c);
    }
    //Fetch all Users whose Id is in the Set.
    //change
    userList = [select Id, ManagerId, Manager1__r.Id, Area_Controller__c, Theater__c, Region__c from User where Id in :userIdSet];
    //Add these fetched Users in a Map <User Id, User object>
    for (User usrObj : userList) {
        userTheaterMap.put(usrObj.Id, usrObj.Theater__c);
        //change
        managerMap.put(usrObj.Id, usrObj.Manager1__r.Id);
        areaControllerMap.put(usrObj.Id, usrObj.Area_Controller__c);
        userMap.put(usrObj.Id, usrObj);
    }
    managerUserList = [select Id, email from User where Id in :managerMap.values()];
    for (User usrObj : managerUserList) {
        managerEmailMap.put(usrObj.Id, usrObj.email);
    }
    System.debug('#########managerEmailMap:' + managerEmailMap);
    //for each Sales_Credit_Claim__C being inserted get User from the map and update the field values
    for (Sales_Credit_Claim__C ccObj : Trigger.new) {
        //get User object
        //change
        String managerId = userMap.get(ccObj.Requestor__c).Manager1__r.Id;
        if (userMap.containsKey(ccObj.OwnerId)) {
            ccObj.Region__c = userMap.get(ccObj.OwnerId).Theater__c;
        }
        System.debug('fieldOpsMap : '+fieldOpsMap);
        System.debug('userMap.get(ccObj.Requestor__c).Region__c : '+userMap.get(ccObj.Requestor__c).Region__c);
        //System.debug('fieldOpsMap.get(userMap.get(ccObj.Requestor__c).Region__c).Approver_User_Id__c : '+fieldOpsMap.get(userMap.get(ccObj.Requestor__c).Region__c).Approver_User_Id__c);
        if (userMap.containsKey(ccObj.Requestor__c) && fieldOpsMap.containsKey(userMap.get(ccObj.Requestor__c).Region__c)) {
            ccObj.Approving_FieldOps__c = fieldOpsMap.get(userMap.get(ccObj.Requestor__c).Region__c).Approver_User_Id__c;
        }
        if (managerEmailMap.containsKey(managerId)) {
            ccObj.Requestor_Manager__c = managerEmailMap.get(managerId);
        }
        ccObj.Approving_RSM__c = managerId;
        if (userMap.containsKey(ccObj.Requestor__c)) {
            ccObj.Approving_AC__c = userMap.get(ccObj.Requestor__c).Area_Controller__c;
        }
        System.debug('ccObj.Approving_FieldOps__c :'+ccObj.Approving_FieldOps__c);
        System.debug('userMap.get(ccObj.Requestor__c).Region__c :'+userMap.get(ccObj.Requestor__c).Region__c);
        if(userMap.get(ccObj.OwnerId).Theater__c == null)
            ccObj.addError('You do not have a Region defined in your user record. You should contact a superuser or administrator to have this fixed.');
        if(userMap.get(ccObj.Requestor__c).Theater__c == 'NA' && ccObj.Approving_FieldOps__c == null)
            ccObj.addError('You do not have a Field Operation Member defined for your Region. You should contact a superuser or administrator to have this fixed.');
        if(ccObj.Requestor_Manager__c == null)
            ccObj.addError('You do not have an RSM defined in your user record. You should contact a superuser or administrator to have this fixed.');
        if(ccObj.Approving_AC__c == null)
            ccObj.addError('You do not have a Region Controller defined in your user record. You should contact a super user or administrator to have this fixed.');
    }
    }
}