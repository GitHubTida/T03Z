/**************************************************************
*    Copyright © 2015 Zebra Technologies. All rights reserved.
*    Author          : Nitin Shivshankara
*    Date            : 6/10/2015
*    Description     : The Trigger for ZEBTargetAccountsAssigningApprovers. 
*    Revision History:
*    Ver       Date        Author                       Modification
*    ----      ---------   -----------                  --------------------
*    V0.1      6/10/2015   Nitin Shivashankara      Initial Code with all the requirements
*********************************************************************************/

trigger ZEBTargetAccountsAssigningApprovers on Modification__c (before insert) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Modification');
    if(objTriggerDeactivate.IsTriggerActive__c){
    Set<String> IdSet = new Set<String>();
    IdSet.add(UserInfo.getUserId());

    Set<Id> TAIdset = new Set<Id>();
    Modification__c[] existingMods = new Modification__c[] {};

    Record_Type__c addRecordTypeID = Record_Type__c.getValues('Modify');

    Map<String, FieldOperationsTeam__c> fieldOpsMap = FieldOperationsTeam__c.getAll();
    for (String fOp : fieldOpsMap.keySet()) {
        IdSet.add(fieldOpsMap.get(fOp).Approver_User_Id__c);
    }

    for (Modification__c m : Trigger.New) {
        IdSet.add((Id)m.Target_Account_Owner_Id__c);
        TAIdSet.add(m.Target_Account__c);
    }

    existingMods = [select Id, createdBy.Id, Target_Account__c, Target_Account__r.OwnerId, RecordType.DeveloperName from Modification__c where Status__c not in ('Rejected', 'Executed') and Target_Account__c in :TAIdSet];
    Set<Id> addModificationRecordIdSet = new Set<Id>();
    Set<Id> dropModificationRecordIdSet = new Set<Id>();
    for (Modification__c modification : existingMods) {
        if (modification.RecordType.DeveloperName == 'Add' && !addModificationRecordIdSet.contains(modification.Target_Account__c))
            addModificationRecordIdSet.add(modification.Target_Account__c);
        else if (modification.RecordType.DeveloperName == 'Drop' && !dropModificationRecordIdSet.contains(modification.Target_Account__c))
            dropModificationRecordIdSet.add(modification.Target_Account__c);
    }
    //change
    Map<Id, User> userMap = new Map<Id, User>([select Id, Area_Controller__c, ManagerId,Manager1__r.Id, Region__c, Theater__c from User where id in:IdSet]);

    Map<Id, RecordType> recordTypeMap = new Map<Id, RecordType>([select Id, DeveloperName from RecordType where SObjectType = 'Modification__c']);
    Map<Id, Target_Account__c> targetMap = new Map<Id, Target_Account__c>([select Id, OwnerId, City__c, State_Province__c, Zip_Postal_Code__c, Country__c, State_Local_Account_Manager__c from Target_Account__c where Id in :TAIdSet]);

    for (Modification__c m : Trigger.New) {
        User currentUser = userMap.get(UserInfo.getUserId());
        String areaApproverId = fieldOpsMap.get(currentUser.Region__c) != null ? fieldOpsMap.get(currentUser.Region__c).Approver_User_Id__c : null;
        if (recordTypeMap.get(m.RecordTypeId).DeveloperName == 'Add') {
            if (areaApproverId != null && currentUser.Theater__c == 'NA') {
                System.debug('FieldOps Approver ---' + areaApproverId);
                m.Approving_FieldOps__c = areaApproverId;
            } else if (areaApproverId == null && currentUser.Theater__c == 'NA') {
                m.addError('You do not have a Field Operation Member defined for your Region. You should contact a superuser or administrator to have this fixed.');
                break;
            }

            m.Approving_AC__c = currentUser.Area_Controller__c;
            //change
            m.Approving_RSM__c = currentUser.Manager1__r.Id;

            if (addModificationRecordIdSet.contains(m.Target_Account__c)) {
                m.addError('There is already an Add request submitted for this Target Account. You will need to wait either until the pending request is Rejected, or until next month after the pending request has been Executed.');
                break;
            }
        } else if (recordTypeMap.get(m.RecordTypeId).DeveloperName != 'Create') {
            if (areaApproverId != null && currentUser.Theater__c == 'NA') {
                System.debug('FieldOps Approver ---' + areaApproverId);
                m.Approving_FieldOps__c = areaApproverId;
            } else if (areaApproverId == null && currentUser.Theater__c == 'NA') {
                m.addError('You do not have a field operation member defined for your Region. You should contact a superuser or administrator to have this fixed.');
                break;
            }

            m.Approving_AC__c = userMap.get(m.Target_Account_Owner_Id__c).Area_Controller__c;
            //change
            m.Approving_RSM__c = userMap.get(m.Target_Account_Owner_Id__c).Manager1__r.Id;

            if (dropModificationRecordIdSet.contains(m.Target_Account__c)) {
                m.addError('There is already a Drop request submitted for this Target Account');
                break;
            }

            if (UserInfo.getUserId() != targetMap.get(m.Target_Account__c).OwnerId)
                m.addError('Only the owner of a Target Account may request Modifications or Drops.');
        } else {
            if (areaApproverId != null && currentUser.Theater__c == 'NA') {
                System.debug('FieldOps Approver ---' + areaApproverId);
                m.Approving_FieldOps__c = areaApproverId;
            } else if (areaApproverId == null && currentUser.Theater__c == 'NA') {
                m.addError('You do not have a field operation member defined for your Region. You should contact a superuser or administrator to have this fixed.');
                break;
            }
            m.Approving_AC__c = currentUser.Area_Controller__c;
            //change
            m.Approving_RSM__c = currentUser.Manager1__r.Id;
        }
        if ((currentUser.Theater__c == 'NA') && (currentUser.Region__c == null))
            m.addError('You do not have a Region defined in your user record. You should contact a superuser or administrator to have this fixed.');

        if (m.Approving_RSM__c == null)
            m.addError('You do not have an RSM defined in your user record. You should contact a superuser or administrator to have this fixed.');

        if (m.Approving_AC__c == null)
            m.addError('You do not have an Region Controller defined in your user record. You should contact a superuser or administrator to have this fixed.');

        /*if (m.Street_Mod_Only__c == 'Yes')
            m.Status__c = 'Approved';*/
        // For Street address modification only
        System.debug('m.IsSplit__c : '+m.IsSplit__c);
        System.debug('m.RecordTypeId : '+m.RecordTypeId);
        //System.debug('addRecordTypeID.Record_Type_Id__c : '+addRecordTypeID.Record_Type_Id__c);
        System.debug('m.City__c : '+m.City__c);
        System.debug('targetMap.get(m.Target_Account__c).City__c : '+targetMap.get(m.Target_Account__c).City__c);
        System.debug('m.State_Province__c : '+m.State_Province__c);
        System.debug('targetMap.get(m.Target_Account__c).State_Province__c : '+targetMap.get(m.Target_Account__c).State_Province__c);
        System.debug('m.Zip_Postal_Code__c : '+m.Zip_Postal_Code__c);
        System.debug('targetMap.get(m.Target_Account__c).Zip_Postal_Code__c : '+targetMap.get(m.Target_Account__c).Zip_Postal_Code__c);
        System.debug('m.Country__c : '+m.Country__c);
        System.debug('targetMap.get(m.Target_Account__c).Country__c : '+targetMap.get(m.Target_Account__c).Country__c);
        System.debug('m.State_Local_Account_Manager__c : '+m.State_Local_Account_Manager__c);
        System.debug('targetMap.get(m.Target_Account__c).State_Local_Account_Manager__c : '+targetMap.get(m.Target_Account__c).State_Local_Account_Manager__c);
        if(m.RecordTypeId == addRecordTypeID.Record_Type_Id__c && (m.City__c == targetMap.get(m.Target_Account__c).City__c || m.City__c=='' || m.City__c==null) && (m.State_Province__c == targetMap.get(m.Target_Account__c).State_Province__c || m.State_Province__c=='' || m.State_Province__c==null) && (m.Zip_Postal_Code__c == targetMap.get(m.Target_Account__c).Zip_Postal_Code__c || m.Zip_Postal_Code__c=='' || m.Zip_Postal_Code__c==null) && (m.Country__c == targetMap.get(m.Target_Account__c).Country__c || m.Country__c=='' || m.Country__c == null) && (m.State_Local_Account_Manager__c == targetMap.get(m.Target_Account__c).State_Local_Account_Manager__c || m.State_Local_Account_Manager__c=='' || m.State_Local_Account_Manager__c==null) && m.IsSplit__c == 'No'){
            System.debug('Inside Street Mod');
            m.Status__c = 'Approved';
        }
    }
    }
}