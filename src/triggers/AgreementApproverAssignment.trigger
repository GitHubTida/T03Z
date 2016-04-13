trigger AgreementApproverAssignment on Apttus__APTS_Agreement__c (before update) {
    
    
   Apttus__APTS_Agreement__c[] agreements = Trigger.new;

	AgreementApproverAssignmentHelper helper = new AgreementApproverAssignmentHelper();
    
	helper.updateApprovalManagerHierarchy(agreements);
    
}