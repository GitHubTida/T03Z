trigger ZEBLead_BIBU_Stage_And_Status_ChangeDate on Lead (before update, before insert) {
   
   if(trigger.isupdate){
        for (Lead newLeadValue : Trigger.new){
            Lead oldLeadValue = Trigger.oldMap.get(newLeadValue.Id);
            
            if(oldLeadValue.Lead_Stage__c != 'MAL' && newLeadValue.Lead_Stage__c == 'MAL') 
                newLeadValue.Lead_Stage_MAL_Date__c = Date.today();
                
            if(oldLeadValue.Lead_Stage__c != 'MQL' && newLeadValue.Lead_Stage__c == 'MQL') 
                newLeadValue.Lead_Stage_MQL_Date__c = Date.today();
                
            if(oldLeadValue.Lead_Stage__c != 'SAL' && newLeadValue.Lead_Stage__c == 'SAL') 
                newLeadValue.Lead_Stage_SAL_Date__c = Date.today();         
                
            if(oldLeadValue.Lead_Stage__c != 'SQL' && newLeadValue.Lead_Stage__c == 'SQL') 
                newLeadValue.Lead_Stage_SQL_Date__c = Date.today();     
                
            if(oldLeadValue.Lead_Stage__c != 'SGL' && newLeadValue.Lead_Stage__c == 'SGL') 
                newLeadValue.Lead_Stage_SGL_Date__c = Date.today();
                
            if(oldLeadValue.Lead_Stage__c != 'Closed Won' && newLeadValue.Lead_Stage__c == 'Closed Won') 
                newLeadValue.Lead_Stage_Closed_Won__c = Date.today();   
        }
    }
    
       if(trigger.isinsert){
        for (Lead newLeadValue : Trigger.new){
                        
            if(newLeadValue.Lead_Stage__c == 'MAL') 
                newLeadValue.Lead_Stage_MAL_Date__c = Date.today();
                
            if(newLeadValue.Lead_Stage__c == 'MQL') 
                newLeadValue.Lead_Stage_MQL_Date__c = Date.today();
                
            if(newLeadValue.Lead_Stage__c == 'SAL') 
                newLeadValue.Lead_Stage_SAL_Date__c = Date.today();         
                
            if(newLeadValue.Lead_Stage__c == 'SQL') 
                newLeadValue.Lead_Stage_SQL_Date__c = Date.today();     
                
            if(newLeadValue.Lead_Stage__c == 'SGL') 
                newLeadValue.Lead_Stage_SGL_Date__c = Date.today();
                
            if(newLeadValue.Lead_Stage__c == 'Closed Won') 
                newLeadValue.Lead_Stage_Closed_Won__c = Date.today();   
        }
    }
}