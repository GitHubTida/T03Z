trigger BDS_Lead_Created_IsAutoMal on Lead (before insert) {
  for(Lead objLead : Trigger.new)
  {
      if(objLead.LeadSource == 'Inbound Call' || 
         objLead.LeadSource == 'Inbound Email' || 
         objLead.LeadSource == 'Click-to-Chat' || 
         objLead.LeadSource == 'Chat + Social Interaction')  
      {
      objLead.Is_Auto_MAL__c = true;
      }
  }
          
}