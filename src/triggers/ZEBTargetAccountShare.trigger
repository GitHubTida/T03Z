/**************************************************************
 *    Copyright © 2015 Zebra Technologies. All rights reserved.
 *    Author          : Nitin Shivshankara
 *    Date            : 6/10/2015
 *    Description    : This trigger shares the TAL record with all the approvers and unshares the record from the former approvers
 *    Revision History:
 *    Ver       Date              Author                    Modification
 *    ----      ---------         -----------               --------------------
 *    1.0       6/10/2015       Nitin Shivashankara        Initial Creation with all the requirements
 *********************************************************************************/

trigger ZEBTargetAccountShare on Target_Account__c (after Update){
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Target Account');
    if(objTriggerDeactivate.IsTriggerActive__c){
    Target_Account__share[] unShares = new Target_Account__share[]{};
    Map<Id,Set<Id>> taShareUserIdMap = new Map<Id,Set<Id>>();
    Map<Id,Target_Account__Share> taShareMap = new Map<Id,Target_Account__Share>();
    Set<Id> idsToBeUnshared = new Set<Id>();
    for(Target_Account__Share targetAccountShare : [select Id, UserOrGroupId, ParentId, AccessLevel, RowCause from Target_Account__Share where RowCause='Auto__c' and ParentId in :Trigger.NewMap.keySet()]){
        Set<Id> tempIdSet = taShareUserIdMap.get(targetAccountShare.ParentId);
        if(tempIdSet == null){
            tempIdSet = new Set<Id>();
            taShareUserIdMap.put(targetAccountShare.ParentId,tempIdSet);
        }
        tempIdSet.add(targetAccountShare.UserOrGroupId);
        taShareMap.put(targetAccountShare.UserOrGroupId,targetAccountShare);
    }
    for(Target_Account__c t : Trigger.new){
        if(t.Owner2__c!=Trigger.oldMap.get(t.Id).Owner2__c || t.Owner3__c!=Trigger.oldMap.get(t.Id).Owner3__c || t.Owner3__c!=Trigger.oldMap.get(t.Id).Owner3__c){
            Set<Id> ownerIds = new Set<Id>();

            if(t.owner2__c != null)
                ownerIds.add(t.owner2__c);
            if(t.owner3__c != null)
                ownerIds.add(t.owner3__c);
            if(t.owner4__c != null)
                ownerIds.add(t.owner4__c);

            /*for(Target_Account__share tas: allShares){
                if(tas.ParentId == t.Id && !ownerIds.contains(tas.UserOrGroupId)){
                    unShares.add(tas);
                }
            }*/
            if(taShareUserIdMap.containsKey(t.Id)){
                Set<Id> tempIdSet = taShareUserIdMap.get(t.Id);
                system.debug('***tempIdSet : '+tempIdSet);
                system.debug('***ownerIds : '+ownerIds);
                tempIdSet.removeAll(ownerIds);
                system.debug('***tempIdSet : '+tempIdSet);
                idsToBeUnshared = tempIdSet;
            }
        }
    }
    if(idsToBeUnshared.size() > 0){
        for(Id userId : taShareMap.keySet())
            unShares.add(taShareMap.get(userId));
    }
    if(unShares.size()>0){
        delete(unShares);
    }
    }
}