trigger BDS_Lead_Update_IsEloquaReOpen on Lead (before update) {
    Lead oldLead = null;
    for (Lead objLead : Trigger.new)
    {
        if(objLead.Is_Eloqua_Re_Open__c) {
            //clear values: string='', date=null, number=0, boolean=false
            objLead.Reason_Won_Loss_Rejected__c = ''; //Lead Status Reason
            objLead.Estimated_Close_Date__c = null;   //Estimated Close Date
            objLead.Hibernate_date_review__c = null;  //Lead Review Date
            objLead.Lead_Value_Lead_Amount__c = 0;    //Lead Value (Lead Ammount)
            objLead.Assign_to_Partner_in__c = '';     //Assign to Partner In
            objLead.Partner_Company_Name__c = null;     //Partner Company Name
            objLead.Partner_Contact_Name__c = null;     //Partner Contact Name
            
            //Added by Vishal Jujaray coz If the Partner Assigned is nullified, the Partner created in MSI should be false
            objLead.Partner_Lead_Created_in_MSI__c = false;     
            //These fields are formula based on Partner_Contact_Name__c and cannot be explicitly assigned values
            //values should clear because Partner_Contact_Name__c is cleared
            //objLead.Partner_Contact_Phone__c = '';  //Partner Contact Phone
            //objLead.Partner_Contact_Email__c = '';  //Partner Contact Email
            
            objLead.Partner_Assigned_Date__c = null;  //Partner Assigned Date
            
            //rest Is_Eloqua_Re_Open__c to false to indicated lead having been processed.
          objLead.Is_Eloqua_Re_Open__c = false;      
        }
    }
}