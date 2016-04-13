trigger SSOCustomerWorkflowRequest on SSO_Customer_Workflow__c (before insert, after insert, after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('SSO Customer Workflow');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        List<String> createUserList = new List<String>();
        SSO_Customer_Workflow__c wfOld = new SSO_Customer_Workflow__c();
        List<SSO_Customer_Workflow__c> sendEmaiList = new List<SSO_Customer_Workflow__c>();
        List<String> userAppRequestedList = new List<String>();
        List<SSO_Email_Out__c> seoList = new List<SSO_Email_Out__c>();
        List<SSO_Application_Mapping__c> allMappings = new List<SSO_Application_Mapping__c>();
        
        allMappings = [Select id,Application_Owner__c,Application_Home_URL__c,Application_Description__c, Provisioner__c,Application_ID__c,Approval_Type__c from SSO_Application_Mapping__c where application_type__c = 'Customer'];
        Map<String, SSO_Application_Mapping__c> mapAllMappings = new Map<String, SSO_Application_Mapping__c>();
        
        for(SSO_Application_Mapping__c ua:allMappings){
            mapAllMappings.put(ua.Application_ID__c , ua); 
        }
        //Before Triggers    
        if(Trigger.isBefore){
            //Populate the workflow details
            for(SSO_Customer_Workflow__c sflow : Trigger.New){
                if(sflow.User_Type__c == 'Customer'){
                    sflow.Requested_Date__c = DateTime.now();
                    if(mapAllMappings.containsKey(sflow.Application_Source__c)){
                        sflow.Maps_to_Application__c = mapAllMappings.get(sflow.Application_Source__c).Id;
                        if(mapAllMappings.get(sflow.Application_Source__c).Application_Owner__c != null)
                            sflow.Approver__c = mapAllMappings.get(sflow.Application_Source__c).Application_Owner__c;
                        if(mapAllMappings.get(sflow.Application_Source__c).Provisioner__c != null)
                            sflow.Provisioner__c = mapAllMappings.get(sflow.Application_Source__c).Provisioner__c;
                    }
                }
            }
        }
        
        //After Triggers
        if(Trigger.isAfter){
            //Submitting the workflow record to the approval process
            for(SSO_Customer_Workflow__c afterSflow : Trigger.New){
                if(Trigger.oldMap != null)
                    wfOld = Trigger.oldMap.get(afterSflow.ID);
                system.debug(' afterSflow.User_Type__c ' +afterSflow.User_Type__c);
                system.debug(' afterSflow.SSO_Request_Id__c ' +afterSflow.SSO_Request_Id__c);
                system.debug(' afterSflow.Application_Status__c ' +afterSflow.Application_Status__c);
                system.debug(' afterSflow.Approval_Type__c ' +afterSflow.Approval_Type__c);
                system.debug(' afterSflow.Provisioning_type__c ' +afterSflow.Provisioning_type__c);
                system.debug(' afterSflow.Approver__c ' +afterSflow.Approver__c);
                system.debug(' afterSflow.Provisioner__c ' +afterSflow.Provisioner__c);
                if(afterSflow.User_Type__c == 'Customer' && afterSflow.SSO_Request_Id__c != null && 
                ((afterSflow.Application_Status__c == 'Requested'  && afterSflow.Approval_Type__c == 'Application Owner') || 
                (wfOld.Application_Status__C != 'Approved' && afterSflow.Application_Status__C == 'Approved'  && afterSflow.Provisioning_type__c == 'Application Owner'))){
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                    req.setComments('Submitted for approval. Please approve.');
                    req.setObjectId(afterSflow.Id);
                    Approval.ProcessResult res = Approval.Process(req);
                    System.debug('Submitted for approval successfully: '+res.isSuccess());
                    if(res.getErrors() != null)
                        System.debug('Error in Submission: '+res.getErrors());
                }
                
                // Create User Requests
                if(afterSflow.User_Type__c == 'Customer' && afterSflow.user_status__c == 'Pending' && afterSflow.Request_type__c =='Create'){
                    createUserList.add(afterSflow.id);
                }
            
                if((afterSflow.Request_Type__c == 'Additional Application Access' && afterSflow.SSO_Request_Id__c == null && afterSflow.Application_Status__c == 'Requested') || (afterSflow.SSO_Request_Id__c != null && wfOld.Application_Status__C != 'Approved' && afterSflow.Application_Status__C == 'Approved' && afterSflow.Approval_Type__c == 'Application Owner') || (afterSflow.SSO_Request_Id__c != null && wfOld.Application_Status__C != 'Provisioned' && afterSflow.Application_Status__C == 'Provisioned' && afterSflow.Provisioning_Type__c == 'Application Owner'))
                    userAppRequestedList.add(afterSflow.id);
                
                // Send Email for the Provisioned Record
                if(afterSflow.User_Type__c == 'Customer' && wfOld != null && wfOld.Application_Status__C != 'Provisioned' && afterSflow.Application_Status__C == 'Provisioned'){
                    SSO_Email_Out__c seo = new SSO_Email_Out__c();
                    seo.Type__c = 'Welcome Kit';
                    seo.Email_Address__c = afterSflow.User_ID__c;
                    seo.Login_URL__c = mapAllMappings.get(afterSflow.Application_Source__c).Application_Home_URL__c;
                    seo.Application_ID__c = afterSflow.Application_Source__c;
                    seo.Attribute_9__c = mapAllMappings.get(afterSflow.Application_Source__c).Application_Description__c;
                    seo.Attribute_10__c = 'True';
                    seo.Attribute_4__c = 'Customer';
                    seo.First_Name__c = afterSflow.First_Name__c;
                    seo.Last_Name__c = afterSflow.Last_Name__c;
                    seoList.add(seo);
                }
            }
            system.debug('createUserList-->'+createUserList);
            if(createUserList.size() > 0){
                ZEBWebServiceCalloutFuture.SSOCustomerCreateUserWebservice(createUserList, 'Create User');
            }
            system.debug('userAppRequestedList-->'+userAppRequestedList);
            if(userAppRequestedList.size() > 0){
                ZEBWebServiceCalloutFuture.UpdateSSOAppProvisioning(userAppRequestedList, 'Customer');
            }
            if(seoList.size()> 0){
                insert seoList;
            }
        }
    }
}