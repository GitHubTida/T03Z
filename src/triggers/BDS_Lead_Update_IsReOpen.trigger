trigger BDS_Lead_Update_IsReOpen on Lead (before update) {
    Lead oldLead = null;
    for (Lead objLead : Trigger.new)
    {       // Vishal Jujaray added the Status as per the Email(June 24th 2015) from Sushanth (Received from Ben Wilke)
      if(objLead.Status == 'New' ||
      objLead.Status == 'In Progress' ||
      objLead.Status == 'Callback' ||
      objLead.Status == 'Marketing Qualified' ||
      objLead.Status == 'Assigned' ||
      objLead.Status == 'Accepted' ||
      objLead.Status == 'Sales Qualified' ||
      objLead.Status == 'Closing Deal' ||
      objLead.Status == 'Converted' )  
      {     //Vishal Jujaray Removed the Old Status 'Rejected' as per the Email from Sushanth (Received from Ben Wilke)
        oldLead = Trigger.oldMap.get(objLead.Id);
        if(oldLead.Status == 'Closed' ||oldLead.Status == 'Closed Lost' ) {
          objLead.Is_Re_Open__c = true;
        }
      }
    }
}