/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : kushal_soni01@infosys.com
Date        : 29-Apr-15 
Description : This trigger is written to grant Read/Write access to Lead Records on the basis of Record Types
Ver       Date        Author              Modification 
---       ---------   -----------         -------------------------
V0.1      29-Apr-15   Kushal Soni         Initial Code
***************************************************************/

trigger ZEBLeadSharing on Lead (after insert,after update) {

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Lead');
    if(objTriggerDeactivate.IsTriggerActive__c){
    
    Id salesLeadRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Sales Generated Lead').getRecordTypeId();
    Id salesAssignLeadRcdTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Sales Assigned Lead').getRecordTypeId();
    Id EloquaLeadRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Eloqua Generated Lead').getRecordTypeId();
    Id marketingLeadRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Marketing Generated Lead').getRecordTypeId();
    
    try{ 
      
    List<LeadShare> leadShareList = new List<LeadShare>();
    for(Lead lead : Trigger.new){
    
        if((lead.RecordTypeId == EloquaLeadRecordTypeID) || (lead.RecordTypeId == marketingLeadRecordTypeID) || (lead.RecordTypeId == salesAssignLeadRcdTypeID)){
            LeadShare leadShare = new LeadShare();
             System.debug('STat');
            leadShare.UserOrGroupId = lead.ZCC_Owner__c;
            leadShare.LeadAccessLevel = 'Edit';
            leadShare.LeadId = lead.id;
            leadShareList.add(leadShare);
        }
        if(lead.RecordTypeId == salesLeadRecordTypeID)
        {
             LeadShare leadShare = new LeadShare();
            System.debug('STat2');
            leadShare.UserOrGroupId = lead.ZCC_Owner__c;
            leadShare.LeadAccessLevel = 'Read';
            leadShare.LeadId = lead.id;
            leadShareList.add(leadShare);
            
        }
    }
     System.debug('*** Sharing ***'+leadShareList);
     Database.SaveResult[] LeadShareInsertResult = Database.insert(leadShareList,false); 
     // Process the save results.
             // Create counter
        Integer i=0;
        
        // Process the save results
        for(Database.SaveResult sr : LeadShareInsertResult ){
            if(!sr.isSuccess()){
                // Get the first save result error
                Database.Error err = sr.getErrors()[0];
                
                // Check if the error is related to a trivial access level
                // Access levels equal or more permissive than the object's default 
                // access level are not allowed. 
                // These sharing records are not required and thus an insert exception is 
                // acceptable. 
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  
                                               &&  err.getMessage().contains('AccessLevel'))){
                    // Throw an error when the error is not related to trivial access level.
                    system.debug('error***'+err.getMessage());
                }
            }else{system.debug('success***');}
            i++;
        }
}

catch(Exception e)
        {
            System.debug('Validation Message : '+e.getMessage());
        }
}
}