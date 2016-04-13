/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : kushal_soni01@infosys.com
Date        : 06-Mar-15
Description : This trigger is written to update Standard field "Email Opt Out" and "Do Not Call" whenever custom fields "Email Opt Out" and "Do Not Call" are populated
Revision History
Ver       Date        Author           Modification
---       ---------   -----------      -------------------------
V0.1      06-Mar-15   Kushal Soni      Initial Code
V0.2      27-Apr-15   Vishal Jujaray   ZCC owner update
V0.3      02-June-15  Kushal Soni      ZCC owner should not fire for Eloqua Interface
 ***************************************************************/
trigger ZEBLead_BIBU_UpdateStandardFields on Lead (before insert, before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Lead');
  
    Record_Type__c eloquaLeadRecordTypeID = Record_Type__c.getValues('Eloqua Lead Record Type');
    Record_Type__c marketingLeadRecordTypeID = Record_Type__c.getValues('Marketing Generated Lead');
    if(objTriggerDeactivate.IsTriggerActive__c){
 try{
        for(Lead lead: Trigger.new){
            // Check if custom 'Email Opt Out' is populated, then populate the standard 'Email Opt Out'
            if(lead.Email_Opt_Out__c=='Yes')
                lead.HasOptedOutOfEmail=TRUE;
            else
                lead.HasOptedOutOfEmail=FALSE;
            // Check if custom 'Do Not call' is populated, then populate the standard 'Do Not Call'
            if(lead.Do_Not_Call__c=='Yes')
                lead.DoNotCall=TRUE;
            else
                lead.DoNotCall=FALSE;
            // Update the ZCC owner - If ZCC owner is blank, then update it to the Lead Owner
            // This is a check for validation if the lead owner is a Queue or a user
            if(lead.RecordTypeID == marketingLeadRecordTypeID.Record_Type_Id__c){
                system.debug('lead.zcc_Owner__c'+lead.zcc_Owner__c);
                system.debug('lead.OwnerId'+lead.OwnerId);
                system.debug('String.valueOf(lead.OwnerId).startsWith'+String.valueOf(lead.OwnerId).startsWith('005'));
                if(lead.zcc_Owner__c==null && String.valueOf(lead.OwnerId).startsWith('005')){
                    lead.zcc_Owner__c=lead.OwnerId;
                }
            }
            // Change status to 'Assigned' once Assign to Partner is populated
   if(trigger.IsUpdate){
            if(lead.Assign_To_Partner_In__c!= null && (Trigger.oldMap.get(lead.Id).Assign_To_Partner_In__c == null))
              lead.Status='Assigned';
          }
        }
 }
 catch(Exception e)
        {
            System.debug('Validation Message : '+e.getMessage());
        }
    }
    
}