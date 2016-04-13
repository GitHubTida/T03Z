trigger TransitionExpired on Partner_Application__c (after update){
	List<Id> accountIdList = new List<Id>();
	List<Account> accountList = new List<Account>();
	Map<Id,String> accountStatusMap = new Map<Id,String>();
	List<Id> partnerAccountIdList = new List<Id>();
	List<Addendum_Program_Contracts__c> addendumList = new List<Addendum_Program_Contracts__c> ();
	for(Partner_Application__c partnerApplication : Trigger.new){
		if(partnerApplication.Transition_Expired__c != Trigger.oldMap.get(partnerApplication.Id).Transition_Expired__c && partnerApplication.Transition_Expired__c && partnerApplication.Partner_Account__c != null){
			accountIdList.add(partnerApplication.Partner_Account__c);
			accountStatusMap.put(partnerApplication.Partner_Account__c,'Expired');
		}
		if((partnerApplication.Application_Status__c != Trigger.oldMap.get(partnerApplication.Id).Application_Status__c) && (partnerApplication.Application_Status__c == 'Transition Declined')){
			accountIdList.add(partnerApplication.Partner_Account__c);
			accountStatusMap.put(partnerApplication.Partner_Account__c,'DeclinedOrApproved');
		}
		if((partnerApplication.Company_Legal_Name__c != Trigger.oldMap.get(partnerApplication.Id).Company_Legal_Name__c)){
			partnerAccountIdList.add(partnerApplication.Id);
		}
	}
	if(accountIdList.size() > 0){
		accountList = [SELECT Id, Transition_Expired__c
		               FROM Account
		               WHERE Id in :accountIdList];
		for(Account account : accountList){
			if(accountStatusMap.get(account.Id) == 'Expired'){
				account.Transition_Expired__c = true;
			}
			account.Transition_Completed_Date__c = system.today();
		}
		update accountList;
	}
	if(partnerAccountIdList.size() > 0){
		addendumList = [SELECT Id, Approver__c, Status__c, Date_Approved__c, Title__c
						FROM Addendum_Program_Contracts__c
						WHERE Partner_Application__c in :partnerAccountIdList];
		if(addendumList.size() > 0){
			for(Addendum_Program_Contracts__c addendum : addendumList){
				addendum.Approver__c = null;
				addendum.Status__c = null;
				addendum.Date_Approved__c = null;
				addendum.Title__c = null;
			}
			update addendumList;
		}
	}
}