/*
 * File Name     : UpdateLegalDocumentStatusOnApplication
 * Description   : This trigger updates the Partner Application based on the application's Legal Agreement documents
 * @author       : Nitin Shivashankara
 *
 * Modification Log
 * =============================================================================
 *   Ver     Date         Author                 Modification
 *------------------------------------------------------------------------------
 *   1.0     01-Oct-15    Nitin Shivashankara    Initial Creation
 */
trigger UpdateLegalDocumentStatusOnApplication on Addendum_Program_Contracts__c (after update){
	List<Id> applicationIdList = new List<Id>();
	List<Partner_Application__c> applicationList = new List<Partner_Application__c>();
	Map<Id,Addendum_Program_Contracts__c> addendumProgramContractsMap = new Map<Id,Addendum_Program_Contracts__c>();
	Map<Id,Partner_Application__c> applicationsMap = new Map<Id,Partner_Application__c>();
	Map<Id,List<Addendum_Program_Contracts__c>> applicationAddendumProgramContractsMap = new Map<Id,List<Addendum_Program_Contracts__c>>();
	Map<Id, String> partnerApplicationLegalDocStatusMap = new Map<Id, String>();
	Set<Id> inProgressApplicationsSet = new Set<Id>();

	for(Addendum_Program_Contracts__c addendumProgContracts : Trigger.new)
		applicationIdList.add(addendumProgContracts.Partner_Application__c);

	if(applicationIdList.size() > 0){
		applicationsMap = new Map<ID, Partner_Application__c>([SELECT Id, Legal_Document_Status__c, Application_Status__c
																	FROM Partner_Application__c
																	WHERE Id in :applicationIdList]);
		for(Addendum_Program_Contracts__c addendumProgContracts : [SELECT Id, Account__c, Approver__c, Category__c, Date_Approved__c, Document_Type__c, Language__c, Partner_Application__c, Partner_Application__r.Legal_Document_Status__c, Partner_Application__r.Application_Status__c, Partner_Program__c, Status__c FROM Addendum_Program_Contracts__c WHERE Partner_Application__c in :applicationIdList ORDER BY Date_Approved__c ASC]){
			addendumProgramContractsMap.put(addendumProgContracts.Id, addendumProgContracts);
			Partner_Application__c partnerApplication = new Partner_Application__c(Id = addendumProgContracts.Partner_Application__c);
			if(!inProgressApplicationsSet.contains(addendumProgContracts.Partner_Application__c) && (addendumProgContracts.Partner_Application__r.Application_Status__c == 'Transition Approved' || addendumProgContracts.Partner_Application__r.Application_Status__c == 'Transition Declined')){
				partnerApplication.Legal_Document_Status__c = 'Completed';
				applicationList.add(partnerApplication);
				inProgressApplicationsSet.add(addendumProgContracts.Partner_Application__c);
				continue;
			}
			if(!inProgressApplicationsSet.contains(addendumProgContracts.Partner_Application__c) && (addendumProgContracts.Date_Approved__c == null)){
				partnerApplication.Legal_Document_Status__c = 'In Progress';
				inProgressApplicationsSet.add(addendumProgContracts.Partner_Application__c);
				applicationList.add(partnerApplication);
				continue;
			}
		}
	}
	if(applicationList.size() > 0)
		update applicationList;
}