/**************************************************************
*    Copyright © 2015 Zebra Technologies. All rights reserved.
*    Author          : Nitin Shivshankara
*    Date            : 6/10/2015
*    Description     : This trigger shares the TAL record with all the approvers and unshares the record from the former approvers
*    Revision History:
*    Ver       Date              Author                     Modification
*    ----      ---------         -----------                --------------------
*    1.0       6/10/2015       Nitin Shivashankara        Initial Creation with all the requirements
*********************************************************************************/
trigger ZEBModificationShare on Modification__c (after Insert, after Update) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Modification');
    if(objTriggerDeactivate.IsTriggerActive__c){
    Approval.ProcessSubmitRequest[] reqs = new Approval.ProcessSubmitRequest[]{};
    Target_Account__share[] taShares = new Target_Account__share[]{};
    Target_Account__share[] unShares = new Target_Account__share[]{};
    Target_Account__share[] allShares = new Target_Account__share[]{};
    Map<Id,Set<Id>> taShareUserIdMap = new Map<Id,Set<Id>>();
    Map<Id,Target_Account__Share> taShareMap = new Map<Id,Target_Account__Share>();
    Set<Id> taIds = new Set<Id>();
    Set<Id> idsToBeUnshared = new Set<Id>();

    if(Trigger.isUpdate){
        for(Modification__c m : Trigger.new)
            taIds.add(m.Target_Account__c);
        for(Target_Account__Share targetAccountShare : [select Id, UserOrGroupId, ParentId, AccessLevel, RowCause from Target_Account__Share where RowCause='Auto__c' and ParentId in :taIds]){
            Set<Id> tempIdSet = taShareUserIdMap.get(targetAccountShare.ParentId);
            if(tempIdSet == null){
                tempIdSet = new Set<Id>();
                taShareUserIdMap.put(targetAccountShare.ParentId,tempIdSet);
            }
            tempIdSet.add(targetAccountShare.UserOrGroupId);
            taShareMap.put(targetAccountShare.UserOrGroupId,targetAccountShare);
        }
    }

    for(Modification__c m : Trigger.new){
        if(m.Status__c!='Approved' && Trigger.isInsert){
            if(m.Approving_FieldOps__c!=null){
                taShares.add( new Target_Account__Share(UserOrGroupId=m.Approving_FieldOps__c, ParentId=m.Target_Account__c, AccessLevel='read', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));
            }
            if(m.Approving_RSM__c!=null){
                if(m.Region__c == 'APAC' || m.Region__c == 'EMEA')
                    taShares.add( new Target_Account__Share(UserOrGroupId=m.Approving_RSM__c, ParentId=m.Target_Account__c, AccessLevel='Edit', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));
                else
                    taShares.add( new Target_Account__Share(UserOrGroupId=m.Approving_RSM__c, ParentId=m.Target_Account__c, AccessLevel='read', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));
            }
            if(m.Approving_AC__c!=null){
                if(m.Region__c == 'APAC' || m.Region__c == 'EMEA')
                    taShares.add( new Target_Account__Share(UserOrGroupId=m.Approving_AC__c, ParentId=m.Target_Account__c, AccessLevel='Edit', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));
                else
                    taShares.add( new Target_Account__Share(UserOrGroupId=m.Approving_AC__c, ParentId=m.Target_Account__c, AccessLevel='read', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));
            }
            if(m.New_Owner__c!=null)
                taShares.add( new Target_Account__Share(UserOrGroupId=m.New_Owner__c, ParentId=m.Target_Account__c, AccessLevel='read', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));

            if(m.Owner2__c!=null)
                taShares.add( new Target_Account__Share(UserOrGroupId=m.Owner2__c, ParentId=m.Target_Account__c, AccessLevel='read', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));

            if(m.Owner3__c!=null)
                taShares.add( new Target_Account__Share(UserOrGroupId=m.Owner3__c, ParentId=m.Target_Account__c, AccessLevel='read', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));

            if(m.Owner4__c!=null)
                taShares.add( new Target_Account__Share(UserOrGroupId=m.Owner4__c, ParentId=m.Target_Account__c, AccessLevel='read', RowCause=Schema.Target_Account__Share.RowCause.Auto__c));

            Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
            req1.setObjectId(m.id);
            req1.setComments(m.Comments__c);
            reqs.add(req1);
        }else if(m.Status__c=='Rejected' && Trigger.isUpdate){
            Set<Id> ownerIds = new Set<Id>();

            if(m.Target_Account__r.owner2__c != null)
                ownerIds.add(m.Target_Account__r.owner2__c);
            if(m.Target_Account__r.owner3__c != null)
                ownerIds.add(m.Target_Account__r.owner3__c);
            if(m.Target_Account__r.owner4__c != null)
                ownerIds.add(m.Target_Account__r.owner4__c);
            if(m.Approving_FieldOps__c!=null)
                ownerIds.add(m.Approving_FieldOps__c);
            if(m.Approving_RSM__c!=null)
                ownerIds.add(m.Approving_RSM__c);
            if(m.Approving_AC__c!=null)
                ownerIds.add(m.Approving_AC__c);
            if(m.New_Owner__c!=null)
                ownerIds.add(m.New_Owner__c);

            /*for(Target_Account__share tas: allShares){
                if(tas.ParentId == m.Target_Account__c && !ownerIds.contains(tas.UserOrGroupId)){
                    unShares.add(tas);
                }
            }*/
            if(taShareUserIdMap.containsKey(m.Target_Account__c)){
                Set<Id> tempIdSet = taShareUserIdMap.get(m.Target_Account__c);
                system.debug('***tempIdSet : '+tempIdSet);
                system.debug('***ownerIds : '+ownerIds);
                tempIdSet.removeAll(ownerIds);
                system.debug('***tempIdSet : '+tempIdSet);
                idsToBeUnshared = tempIdSet;
            }
        }
    }
    system.debug('***idsToBeUnshared : '+idsToBeUnshared);
    if(idsToBeUnshared.size() > 0){
        for(Id userId : idsToBeUnshared)
            unShares.add(taShareMap.get(userId));
    }
    system.debug('***unShares : '+unShares);
    if(reqs.size()>0)
        Approval.ProcessResult[] result = Approval.process(reqs);
    if(taShares.size()>0)
        insert(taShares);
    if(unShares.size()>0)
        delete(unShares);
}
}