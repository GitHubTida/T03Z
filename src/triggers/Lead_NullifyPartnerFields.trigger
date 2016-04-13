/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : kushal_soni01@infosys.com
Date        : 22-Jun-15
Description : This trigger is written to nullify Partner related fields when Lead Status is updated in NewCo as Closed Lost/ Rejected from MSI 
Revision History
Ver       Date        Author           Modification
---       ---------   -----------      -------------------------
V0.1      22-Jun-15   Kushal Soni      Initial Code
V0.2      30-Jun-15   Vishal Jujaray   removed the Condition for last modified by = zzebi
 ***************************************************************/

trigger Lead_NullifyPartnerFields on Lead (BEFORE update) {
   
  // List<Lead> lead = [Select Id, Status, Partner_Lead_Created_in_MSI__c, Partner_Company_Name__c, Partner_Contact_Name__c, Partner_Assigned_Date__c from Lead where LastModifiedBy.Name = 'zebinfaint zebinfaint']
  
     try
     {
      for(Lead lead: Trigger.New)
      {
        //if(lead.LastModifiedBy.Alias== 'zzebi' && ((lead.Status == 'Closed - Lost') || (lead.Status == 'Rejected') || (lead.Status == 'Closed Lost')))
        if(((lead.Status == 'Closed - Lost') || (lead.Status == 'Rejected') || (lead.Status == 'Closed Lost')) && lead.Assign_to_Partner_in__c == 'MSI SFDC')
        {
          lead.Assign_to_Partner_in__c = '';
          lead.Partner_Lead_Created_in_MSI__c = FALSE;
          lead.Partner_Company_Name__c = NULL;
          lead.Partner_Contact_Name__c = NULL;
          lead.Partner_Assigned_Date__c = NULL;
        }
        
        if(lead.Status == 'Closing Deal')
        {
          lead.Cancel_Workflow__c = TRUE;
        }
      
     }
     }
     catch(Exception e)
        {
            System.debug('Validation Message : '+e.getMessage());
        }
    
      
   
}