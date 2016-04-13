trigger SSOProcessRequest on SSO_Workflow__c (before insert,before update, after insert, after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('SSO Workflow');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        //Variable declaration
        List<Id> relatedContact = new List<Id>();
        List<Id> accountIds = new List<Id>();
        List<Id> contactIds = new List<Id>();
        List<Id> recordIds = new List<Id>();
        List<Id> revoContactIds = new List<Id>();
        List<Contact> contactList = new List<Contact>();
        List<Contact> contactRevokeList = new List<Contact>();
        List<Contact> deactivateContactList = new List<Contact>();
        Map<Id, Contact> conMap = new Map<Id, Contact>();
        Map<ID, ID> cadminMap = new Map<Id, Id>();
        Map<ID, ID> userMap = new Map<Id, Id>();
        Map<ID, ID> uadminMap = new Map<Id, Id>();
        Map<Id,String> allAdminMap = new Map<Id,String>();
        Map<Id,String> conAppMap = new Map<Id,String>();
        Map<Id,String> conAppRevokeMap = new Map<Id,String>();
        List<SSO_Workflow__c> provisionedDRRequests = new List<SSO_Workflow__c>();
        List<SSO_Email_Out__c> sendEmailList = new List<SSO_Email_Out__c>();
        Map<String,Record_Type__c> PMIRecordType = Record_Type__c.getAll();
        Map<String,PIC_Queue_Ids__c> PICQueueIds = PIC_Queue_Ids__c.getAll();
        List<Id> appFlowDeleteList = new List<Id>();
        
        // Populate the Contact Related Details
        for(SSO_Workflow__c  uapb: Trigger.new){
            if(uapb.User_Type__c == 'Partner'){
                relatedContact.add(uapb.Related_Contact__c);    
            }
            recordIds.add(uapb.id);
        }
        
        // Application related data fetching        
        List<SSO_Application_Mapping__c> allMappings = new List<SSO_Application_Mapping__c>();
        allMappings = [Select id, Application_Name__c,Application_Owner__c,Application_ID__c,Approval_Type__c from SSO_Application_Mapping__c];
        Map<String, SSO_Application_Mapping__c> mapAllMappings = new Map<String, SSO_Application_Mapping__c>();
        for(SSO_Application_Mapping__c ua:allMappings){
            mapAllMappings.put(ua.Application_Name__c , ua); 
        }   
        
        //Before triggers
        if(Trigger.isBefore){
            system.debug('Before Insert');
            if(relatedContact != null && relatedContact.size() > 0){
                //Fetch details of all the related contacts
                List<Contact> cons = [Select id, email, firstname, lastname, accountid, account.Program_Membership_Information__c, account.Partner_Zone__c, Secondary_Role__c, Tool_Access__c from Contact where id in : relatedContact];
                for(Contact c: cons){
                    conMap.put(c.id, c);
                }
                //Update contact and account related details
                if(conMap.size() > 0){
                    for(SSO_Workflow__c  uapb: Trigger.new){
                        if(conMap.get(uapb.Related_Contact__c).firstname != null && conMap.get(uapb.Related_Contact__c).firstname != '' && conMap.get(uapb.Related_Contact__c).lastname != null && conMap.get(uapb.Related_Contact__c).lastname != ''){
                            uapb.Name__c = conMap.get(uapb.Related_Contact__c).firstname + ' ' +  conMap.get(uapb.Related_Contact__c).lastname ;
                            uapb.First_Name__c = conMap.get(uapb.Related_Contact__c).firstname;
                        } else
                            uapb.Name__c = conMap.get(uapb.Related_Contact__c).lastname;
                        uapb.Last_Name__c = conMap.get(uapb.Related_Contact__c).lastname;
                        uapb.email__c = conMap.get(uapb.Related_Contact__c).email ;
                        uapb.Related_Account__c = conMap.get(uapb.Related_Contact__c).accountid ;
                        uapb.Partner_Secondary_Role__c = conMap.get(uapb.Related_Contact__c).Secondary_Role__c;
                        uapb.Partner_Tool_Access__c = conMap.get(uapb.Related_Contact__c).Tool_Access__c;
                        uapb.Partner_Zone__c = conMap.get(uapb.Related_Contact__c).account.Partner_Zone__c;
                        accountIds.add(conMap.get(uapb.Related_Contact__c).accountid);
                    }
                }
                
                //Get the user and admin details
                List<User> adminusers = [Select id, contactid, accountid, Theater__c, contact.Contact_Status__c, contact.Partner_Administrator__c, contact.Partner_Admin_Sequence_Number__c from user where accountid in :accountIds ORDER BY Contact.Partner_Admin_Sequence_Number__c ASC];
                system.debug('adminusers-->'+adminusers );
                system.debug('accountIds-->'+accountIds );
                if(adminusers.size() > 0){
                    for(User u :adminusers){
                        if(u.contact.Partner_Administrator__c && u.Contact.Contact_Status__c == 'Active'){
                            if(!cadminMap.containsKey(u.AccountId))
                                cadminMap.put(u.AccountId, u.ContactId);
                            allAdminMap.put(u.ContactId,u.Theater__c);
                        }
                        userMap.put(u.ContactId, u.Id);
                    }
                    system.debug('cadminMap-->'+cadminMap);
                    system.debug('userMap-->'+userMap);
                    for(SSO_Workflow__c  uapb: Trigger.new){
                        if(userMap.containsKey(uapb.Related_Contact__c))
                            uapb.Related_User__c = userMap.get(uapb.Related_Contact__c);
                        if(cadminMap.get(uapb.Related_Account__c) == uapb.Related_Contact__c){
                            //do nothing
                        }else{
                            uapb.Related_Contact_Admin__c= cadminMap.get(uapb.Related_Account__c);
                            uapb.Approver__c = userMap.get(uapb.Related_Contact_Admin__c);
                        }
                    }
                }
                
                //Approver and application owner update
                for(SSO_Workflow__c  uapb: Trigger.new){
                    if(uapb.Request_type__c == 'Application Grant Access'){
                        if(uapb.Application_Name__c != null){
                            if(uapb.Application_Name__c == SYSTEM.Label.SSO_App_Deal_Registration)
                                uapb.Application_Name__c = 'Deal Registration';
                            else if(uapb.Application_Name__c == SYSTEM.Label.SSO_App_Order_Provisioning_Tool)
                                uapb.Application_Name__c = 'Order Provisioning Tool';
                            uapb.Maps_to_Application__c = mapAllMappings.get(uapb.Application_Name__c).id;
                            if(mapAllMappings.get(uapb.Application_Name__c).Application_Owner__c != null){
                                uapb.Application_Owner__c = mapAllMappings.get(uapb.Application_Name__c).Application_Owner__c;
                            }
                            if(mapAllMappings.get(uapb.Application_Name__c).Approval_Type__c == 'Application Owner')
                                uapb.Approver__c = mapAllMappings.get(uapb.Application_Name__c).Application_Owner__c;
                        }
                        if(uapb.Approver__c == null)
                            uapb.Approver__c = uapb.Application_Owner__c ;
                    }
                    // all the initial data population is complete and now the request can be submitted to approval
                    if(uapb.Request_type__c == 'Application Grant Access' && uapb.Process_status__c == 'Pending'){
                        uapb.Ready_for_Approval__c = true;
                        if((uapb.Request_Source__c != 'Self' && uapb.Application_Name__c == 'Deal Registration') || (uapb.Request_Source__c == 'PIC' && mapAllMappings.get(uapb.Application_Name__c).Approval_Type__c == 'PIC'))
                            uapb.Process_status__c = 'Requested';
                    }
                    //Logic to auto-provision delegated and PIC requests where Approval Type is Account Administrator
                    //system.debug('Check Approval Type formula->'+mapAllMappings.get(uapb.Application_Name__c).Approval_Type__c);
                    if((uapb.Request_Source__c == 'Delegated' || uapb.Request_Source__c == 'PIC') && (uapb.Process_status__c == 'Pending' || uapb.Process_status__c == 'Requested') && uapb.Request_Type__c == 'Application Grant Access' && (mapAllMappings.get(uapb.Application_Name__c).Approval_Type__c == 'Account Administrator' || mapAllMappings.get(uapb.Application_Name__c).Approval_Type__c == 'Auto Approval')){
                        uapb.Process_status__c = 'Provisioned';
                        uapb.Provisioned_Rejected_Date__c = DateTime.Now();
                        if(uapb.Requested_Date__c == null){
                            uapb.Requested_Date__c = DateTime.Now();
                        }
                    }
                    if(uapb.Request_Source__c == 'PIC' && uapb.Request_type__c == 'Application Grant Access' && uapb.Process_status__c == 'Requested' && mapAllMappings.get(uapb.Application_Name__c).Approval_Type__c == 'PIC' && uapb.SSO_Request_Id__c != null && uapb.SSO_Request_Id__c != ''){
                        uapb.Process_status__c = 'Provisioned';
                        uapb.Provisioned_Rejected_Date__c = DateTime.Now();
                    }
                    //Directly deactivate bulk Deactivate user requests
                    if(uapb.Request_Source__c == 'Bulk' && uapb.Request_Type__c == 'Deactivate User' && uapb.Process_Status__c == 'Approved'){
                        uapb.Process_Status__c = 'Deactivated';
                    }
                }
            }
        }
        
        if(Trigger.isAfter){
            if(relatedContact != null && relatedContact.size() > 0){
                //Variable Declaration
                List<String> dealworkflowList = new List<String>();
                List<String> dealRevokeWorkflowList = new List<String>();
                List<String> siebelworkflowList = new List<String>();
                List<String> PICsiebelworkflowList = new List<String>();
                List<String> siebeluserupdateList = new List<String>();
                List<String> contactUpdateList = new List<String>();
                List<String> workflowlist = new List<String>();
                
                for(SSO_Workflow__c ar:Trigger.new ){
                    //Submitting the workflow record to the approval process
                    if(ar.Process_status__c == 'Pending' && (( ar.Approval_Type__c <> 'Auto Approval' && ((ar.Request_Source__c != 'Default' && ar.Request_Source__c != 'Delegated' && ar.Request_Source__c != 'PIC' && ar.Approval_Type__c == 'Account Administrator') || (ar.Approval_Type__c == 'PIC' && ar.Request_Source__c != 'PIC')) && ar.Request_Type__c == 'Application Grant Access')
                     || (ar.Request_Source__c == 'Delegated' && ar.Request_Type__c == 'Deactivate User'))){
                         system.debug(' Inside approval request ' + ar.Admin_Request__c);
                         Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                         req.setComments('Submitted for approval. Please approve.');
                         system.debug('ar.id --> '+ar.id);
                         req.setObjectId(ar.Id);
                         system.debug('req --> '+req);
                         Approval.ProcessResult result = Approval.process(req);
                            
                         System.debug('Submitted for approval successfully: '+result.isSuccess());
                     
                     }
                     
                    //Application Grant Access Logic
                    if(ar.Request_Source__c != 'Default' && ar.Process_status__c == 'Provisioned' && ar.Request_Type__c == 'Application Grant Access' && ar.application_name__c == 'Deal Registration'){
                        dealworkflowList.add(ar.Id);
                        system.debug('Nimsi '+ar.id);
                        conAppMap.put(ar.Related_Contact__c, ar.application_name__c);
                    }
                    if(ar.Request_Type__c == 'Application Grant Access' && ar.application_name__c == 'Order Provisioning Tool' && ((ar.Process_status__c == 'Provisioned' && ar.Request_Source__c <> 'PIC') || (ar.Process_status__c == 'Requested' && ar.Request_Source__c == 'PIC'))){
                        siebelworkflowList.add(ar.Id);
                        conAppMap.put(ar.Related_Contact__c, ar.application_name__c);
                    }
                    if(ar.Request_Source__c == 'Default' && ar.Process_Status__c == 'Provisioned' && ar.application_name__c == 'Deal Registration'){
                        conAppMap.put(ar.Related_Contact__c, ar.application_name__c);
                    }
                    if(((ar.Process_status__c == 'Requested' && ar.SSO_Request_Id__c == null)  ||  (ar.Provisioning_Type__c != 'Auto Provisioning' && ar.Process_status__c == 'Approved') || ar.Process_status__c == 'Rejected' || (ar.Process_status__c == 'Provisioned' && (ar.Application_Name__c <> 'Order Provisioning Tool' || (ar.Application_Name__c == 'Order Provisioning Tool' && ar.Request_Source__c <> 'PIC')))) && ar.Request_Type__c == 'Application Grant Access' && ar.Request_Source__c <> 'Default'){
                        workflowlist.add(ar.id);
                    }
                    if(ar.Request_Source__c == 'PIC' && ar.Request_type__c == 'Application Grant Access' && ar.Process_status__c == 'Provisioned' && ar.Approval_Type__c == 'PIC'){
                        PICsiebelworkflowList.add(ar.Id);
                    }
                    if(ar.Process_Status__c == 'Provisioned' && ar.Request_Type__c == 'Application Grant Access' && ar.Application_Name__c == 'Deal Registration'){
                        provisionedDRRequests.add(ar);
                    }
                    if(ar.Request_Type__c == 'Application Grant Access' && ar.Process_Status__c == 'Provisioned' && (ar.Application_Name__c == 'Distribution Partner Download' || ar.Application_Name__c == 'Distribution Material Download')){
                        conAppMap.put(ar.Related_Contact__c, ar.application_name__c);
                    }
                    
                    //Application Revoke Access Logic
                    if(ar.Request_Type__c == 'Application Revoke Access' && ar.Process_Status__c == 'Revoked'){
                        if(ar.Request_Source__c != 'Bulk')
                            conAppRevokeMap.put(ar.Related_Contact__c, ar.Application_Name__c);
                        else{
                            revoContactIds.add(ar.Related_Contact__c);
                            appFlowDeleteList.add(ar.Id);
                        }
                        if(ar.application_name__c == 'Order Provisioning Tool')
                            siebelworkflowList.add(ar.Id);
                        else if(ar.Application_Name__c == 'Deal Registration' && ar.Request_Source__c != 'Default')
                            dealRevokeWorkflowList.add(ar.Id);
                    }
                    
                    //Application Reject Logic
                    if(ar.Process_Status__c == 'Rejected'){
                        List<Contact> rejContactList = new List<Contact>();
                        Contact relCon = new Contact(id = ar.Related_Contact__c);
                        if(ar.Application_Name__c == 'Deal Registration'){
                            relCon.Deal_Registration_T_C_Accepted__c = FALSE;
                            rejContactList.add(relCon);
                        } else if(ar.Application_Name__c == 'Order Provisioning Tool'){
                            relCon.Siebel_Attribute_1__c = FALSE;
                            relCon.Siebel_Attribute_2__c = FALSE;
                            relCon.Siebel_Attribute_3__c = FALSE;
                            relCon.Siebel_Attribute_4__c = FALSE;
                            relCon.Siebel_Attribute_5__c = FALSE;
                            relCon.Siebel_Attribute_6__c = FALSE;
                            relCon.Siebel_Attribute_7__c = FALSE;
                            rejContactList.add(relCon);
                        }
                        update rejContactList;
                    }
                }
                if(dealworkflowList != null && dealworkflowList.size() > 0)
                    SSOTriggerHandler.assignPermissionSetFuture(dealworkflowList);
                
                if(dealRevokeWorkflowList != null && dealRevokeWorkflowList.size() > 0)
                    SSOTriggerHandler.deletePermissionSetFuture(dealRevokeWorkflowList);
               
                if(siebelworkflowList != null && siebelworkflowList.size() > 0) {    
                 system.debug('siebelworkflowList :::'+siebelworkflowList );
                    ZEBWebServiceCalloutFuture.getSFDCtoSiebelCreateUpdateRevokeFuture(siebelworkflowList); 
                }
                system.debug(' workflowlist ' +workflowlist);
                if(workflowlist != null && workflowlist.size() > 0){
                    ZEBWebServiceCalloutFuture.UpdateSSOAppProvisioning(workflowlist,'Partner');
                }
                if(PICsiebelworkflowList != null && PICsiebelworkflowList.size() > 0){
                    ZEBWebServiceCalloutFuture.UpdateSSOAppProvisioningDirect(PICsiebelworkflowList,'Partner');
                }
                
                if(conAppMap != null && conAppMap.size() > 0 ){ 
                    contactList = [Select id, Contact_Status__c,Tool_Access__c, Deal_Registration_T_C_Accepted__c from Contact where id in :conAppMap.keySet()];
                    for(Contact c:contactList){
                        if(c.Tool_Access__c == null) 
                            c.Tool_Access__c = conAppMap.get(c.id);
                        else if(c.Tool_Access__c != null && !c.Tool_Access__c.contains(conAppMap.get(c.id))){
                            c.Tool_Access__c = c.Tool_Access__c + ';' + conAppMap.get(c.id);
                            system.debug('c.Tool_Access__c.contains(conAppMap.get(c.id))-->'+c.Tool_Access__c.contains(conAppMap.get(c.id)));
                        }
                        if(conAppMap.get(c.id) == 'Deal Registration' && !c.Deal_Registration_T_C_Accepted__c)
                            c.Deal_Registration_T_C_Accepted__c = TRUE;
                    }
                    update contactList;
                }
                
                system.debug('conAppRevokeMap->'+conAppRevokeMap);
                if(conAppRevokeMap != null && conAppRevokeMap.size() > 0){
                    contactRevokeList = [Select id, Contact_Status__c,Tool_Access__c,Deal_Registration_T_C_Accepted__c from Contact where id in :conAppRevokeMap.keySet()];
                    system.debug('conAppRevokeMap->'+conAppRevokeMap);
                    for(Contact c:contactRevokeList){
                        if(c.Tool_Access__c != null && c.Tool_Access__c.contains(conAppRevokeMap.get(c.Id))){
                            system.debug('Tool->'+c.Tool_Access__c+' After Remove->'+c.Tool_Access__c.remove(conAppRevokeMap.get(c.Id)));
                            c.Tool_Access__c = c.Tool_Access__c.remove(conAppRevokeMap.get(c.Id));
                        }
                        if(conAppRevokeMap.get(c.Id) == 'Deal Registration')
                            c.Deal_Registration_T_C_Accepted__c = FALSE;
                    }
                    update contactRevokeList;
                    system.debug('after contactRevokeList '+contactRevokeList);
                }
                system.debug('revoContactIds-->'+revoContactIds);
                if(revoContactIds != null && revoContactIds.size() > 0){
                    List<Contact> revokeContacts = new List<Contact>();
                    for(Contact con : [Select Id, Tool_Access__c FROM Contact WHERE Id IN :revoContactIds]){
                        if(con.Tool_Access__c != null){
                            con.Tool_Access__c = '';
                            revokeContacts.add(con);
                        }
                    }
                    update revokeContacts;
                    system.debug('revokeContacts-->'+revokeContacts);
                }
                if(provisionedDRRequests != null && provisionedDRRequests.size() > 0 ){
                    for(SSO_Workflow__c sf : provisionedDRRequests){
                        SSO_Email_Out__c ssoemail = new SSO_Email_Out__c();
                        ssoemail.First_Name__c = sf.First_Name__c;
                        ssoemail.Last_Name__c = sf.Last_Name__c;
                        ssoemail.Email_Address__c = sf.Email__c;
                        ssoemail.Attribute_1__c = sf.Partner_Region__c;
                        ssoemail.Attribute_2__c = sf.Related_Contact__c;
                        ssoemail.Type__c = 'Deal Registration Welcome Kit';
                        sendEmailList.add(ssoemail);
                    }
                    try{
                        system.debug('sendEmailList-->'+sendEmailList);
                        insert sendEmailList;
                    } catch(Exception e){
                        system.debug('Exception occurred while inserting email records: '+e.getMessage());
                    }
                }
            }
            
            //Deactivate User Logic
            List<Id> usersToDeactivateList = new List<Id>();
            List<String> deactivateWorkflowList = new List<String>();
            for(SSO_Workflow__c sflow : Trigger.New){
                if(sflow.User_Type__c == 'Partner' && sflow.Request_Type__c == 'Deactivate User' && sflow.Process_Status__c == 'Approved')
                    deactivateWorkflowList.add(sflow.Id);
                if(sflow.User_Type__c == 'Partner' && sflow.Request_Type__c == 'Deactivate User' && (sflow.Process_Status__c == 'Approved' || (sflow.Process_Status__c == 'Deactivated' && sflow.Request_Source__c == 'Bulk'))){
                    usersToDeactivateList.add(sflow.Related_User__c);
                    Contact con = new Contact(Id = sflow.Related_Contact__c);
                    con.Contact_Status__c = 'Inactive';
                    con.Tool_Access__c = null;
                    deactivateContactList.add(con);
                }
            }
            try{
                system.debug('deactivateContactList-->'+deactivateContactList);
                update deactivateContactList;
            } catch(Exception e){
                system.debug('Exception Occurred while deactivating the contact : '+e.getMessage());
                system.debug('Exception Occurred at line'+e.getLineNumber());
            }
            
            system.debug('appFlowDeleteList-->'+appFlowDeleteList);
            if(appFlowDeleteList != null && appFlowDeleteList.size() > 0){
                SSOTriggerHandler.deleteAppRequestsofInactiveContact(appFlowDeleteList);
            }
            
            if(deactivateWorkflowList != null && deactivateWorkflowList.size() > 0)
                SSOTriggerHandler.deletePermissionSetFuture(deactivateWorkflowList);

            if(usersToDeactivateList != null && usersToDeactivateList.size() > 0)
                SSOTriggerHandler.deactivateUser(usersToDeactivateList);
        }
    }
}