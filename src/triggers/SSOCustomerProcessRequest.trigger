trigger SSOCustomerProcessRequest on SSO_Workflow__c (before insert, after insert, after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('SSO Workflow');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        List<String> workflowIdList = new List<String>();
        List<String> sflowlist = new List<String>();
        
        //Before Triggers
        if(Trigger.isBefore){
            //Fetch all the application related data
            List<SSO_Application_Mapping__c> allMappings = new List<SSO_Application_Mapping__c>();
            allMappings = [Select id, Application_Name__c,Application_Owner__c,Application_ID__c,Approval_Type__c from SSO_Application_Mapping__c];
            Map<String, SSO_Application_Mapping__c> mapAllMappings = new Map<String, SSO_Application_Mapping__c>();
            for(SSO_Application_Mapping__c ua:allMappings){
                mapAllMappings.put(ua.Application_Name__c , ua); 
            }
            
            //Populate the workflow details
            for(SSO_Workflow__c sflow : Trigger.New){
                if(sflow.User_Type__c == 'Customer'){
                    sflow.Requested_Date__c = DateTime.now();
                    if(mapAllMappings.containsKey(sflow.Application_Name__c)){
                        sflow.Maps_to_Application__c = mapAllMappings.get(sflow.Application_Name__c).Id;
                        sflow.Application_Owner__c = mapAllMappings.get(sflow.Application_Name__c).Application_Owner__c;
                        if(mapAllMappings.get(sflow.Application_Name__c).Approval_Type__c == 'Auto Approval' && 
                           sflow.Request_Type__c == 'Application Grant Access' && sflow.Process_Status__c == 'Pending'){
                               system.debug('Inside If provision');
                               sflow.Process_Status__c = 'Provisioned';
                               sflow.Provisioned_Rejected_Date__c = DateTime.now();
                           }
                    }
                }
            }
        }
        
        //After Triggers
        if(Trigger.isAfter){
            //Submitting the workflow record to the approval process
            for(SSO_Workflow__c afterSflow : Trigger.New){
                if(afterSflow.User_Type__c == 'Customer' && afterSflow.Request_Type__c == 'Application Grant Access' && afterSflow.Process_Status__c == 'Pending' && afterSflow.Approval_Type__c != 'Auto Approval'){
                    Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
                    req.setComments('Submitted for approval. Please approve.');
                    req.setObjectId(afterSflow.Id);
                    Approval.ProcessResult res = Approval.Process(req);
                    System.debug('Submitted for approval successfully: '+res.isSuccess());
                }
                
                if(afterSflow.User_Type__c == 'Customer' && afterSflow.Request_Type__c == 'Application Grant Access' && afterSflow.Application_Source_System__c == 'Siebel' && afterSflow.Process_Status__c == 'Provisioned'){
                    workflowIdList.add(afterSflow.Id);
                }
                
                if(afterSflow.User_Type__c == 'Customer' && ((afterSflow.Process_status__c == 'Requested' && afterSflow.SSO_Request_Id__c == null)  ||  afterSflow.Process_status__c == 'Approved' || afterSflow.Process_status__c == 'Rejected' || afterSflow.Process_status__c == 'Provisioned') && afterSflow.Request_Type__c == 'Application Grant Access'){
                    sflowlist.add(afterSflow.id);
                }
            }
            system.debug('workflowIdList-->'+workflowIdList);
            if(workflowIdList.size() > 0){
                ZEBWebServiceCalloutFuture.SSOCustomerAppWebservice(workflowIdList);
            }
            system.debug('sflowlist-->'+sflowlist);
            if(sflowlist.size() > 0){
                ZEBWebServiceCalloutFuture.UpdateSSOAppProvisioning(sflowlist, 'Partner');
            }
        }
    }
}