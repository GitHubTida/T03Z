/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : rohith_pamulasai@infosys.com
Date        : 19-Feb-15 
Description: This trigger auto converts a lead to an opportunity when lead status is 'Closed-Won'
Revision History 
Ver       Date        Author           Modification 
---       ---------   -----------      -------------------------
V0.1      19-Feb-15   Rohith Raj       Initial Code
V0.2      26-Feb-15   Nimesh Sharma    Added Checks for RecordType and Convert Implementation 
V0.3      03-Mar-15   Kushal Soni      Added Conversion Mapping
V0.4      03-Mar-15   Vishal Jujaray   Included the Marketing generated Lead RecordTypes
V0.5      15-Apr-15   Kushal Soni      Added checks to know whether Lead Owner is a user or queue 
V0.6      26-Apr-15   Vishal Jujaray   Added Sales assigned and Eloqua RTs 
V0.7      18-May-15   Kushal Soni      Changed Status condition from Closed to Sales Qualified 
V0.8      26-May-15   Priyanka Singh   Added checks for Lead Value greater than 100 and less than 25000
V0.9      30-June-15  Vishal Jujaray    Removed the Lead Status  Sales Qualified  from Auto Conversion
***************************************************************/
trigger ZEBLead_AIAU_AutoConvertLeadToOpportunity on Lead (after insert,after update) 
{

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Lead');
    if(objTriggerDeactivate.IsTriggerActive__c){
    try {
    String currentUser = userInfo.getUserId();
    List<Database.LeadConvert> listOfLeadsToBeConverted = new List<Database.LeadConvert>();
    List<Lead> lead1=Trigger.new;
    Id salesLeadRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Sales Generated Lead').getRecordTypeId();
    Id salesAssignLeadRcdTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Sales Assigned Lead').getRecordTypeId();
    Id EloquaLeadRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Eloqua Generated Lead').getRecordTypeId();
    Id marketingLeadRecordTypeID = Schema.SObjectType.Lead.getRecordTypeInfosByName().get('Marketing Generated Lead').getRecordTypeId();
    Id AutoConvertRecordTypeID = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('AutoConvert Opportunity').getRecordTypeId();
    List<Account> accountsList = new List<Account>();
    List<Contact> contactsList = new List<Contact>();
    Map<String, ID> accountsMap = new Map<String, ID>();
    Map<String, ID> contactsMap = new Map<String, ID>();
    List<Lead> leads =Trigger.new;
    Map<ID, Lead> leadsMap = new Map<ID, Lead>();
    //Inserting Lead Records in Map
    for(Lead leadList: leads)
    {
     leadsMap.put(leadList.Id,leadList);
    }
    // Lead to Account Mapping
    for (Lead leadRecord: Trigger.new){
        //if((leadRecord.status == 'Sales Qualified' || leadRecord.status == 'Closing Deal') && (leadRecord.RecordTypeID == SalesLeadRecordTypeID || leadRecord.RecordTypeID == salesAssignLeadRcdTypeID || leadRecord.RecordTypeID == EloquaLeadRecordTypeID || leadRecord.RecordTypeID == marketingLeadRecordTypeID) && leadRecord.Partner_Company_Name__c!=null && (leadRecord.Lead_Value_Lead_Amount__c>100 && leadRecord.Lead_Value_Lead_Amount__c<25000) && !leadRecord.isConverted){
        if((leadRecord.status == 'Closing Deal') && (leadRecord.RecordTypeID == SalesLeadRecordTypeID || leadRecord.RecordTypeID == salesAssignLeadRcdTypeID || leadRecord.RecordTypeID == EloquaLeadRecordTypeID || leadRecord.RecordTypeID == marketingLeadRecordTypeID) && leadRecord.Partner_Company_Name__c!=null && (leadRecord.Lead_Value_Lead_Amount__c>100 && leadRecord.Lead_Value_Lead_Amount__c<25000) && !leadRecord.isConverted){
            Record_Type__c rect = Record_Type__c.getValues('Prospect');
            Account acc = new Account();
            acc.Name = leadRecord.Company;
            acc.BillingCountrycode = leadRecord.countrycode;
            acc.BillingStreet = leadRecord.Street;            
            acc.BillingCity = leadRecord.City;   
            acc.BillingStatecode = leadRecord.Statecode; 
            acc.RecordTypeID = rect.Record_Type_Id__c;
            acc.AccountSource = leadRecord.LeadSource;
            
            String leadOwnerId = leadRecord.OwnerId;
            if(!leadOwnerId.startsWith('00G'))
            {
              acc.OwnerId = leadRecord.OwnerId;
            }
            else
            {
              acc.OwnerId = currentUser;
            }
            System.debug('account owner id: '+acc.OwnerId);
            System.debug('lead owner id: '+leadRecord.OwnerId);
            accountsList.add(acc);
        }
    }
    insert accountsList;
    
    for(Account acc:accountsList){
        accountsMap.put(acc.name, acc.id);
    }
    // Lead to Contact Mapping
    if(accountsMap != null){
        for (Lead leadRecord: Trigger.new){
            //if((leadRecord.status == 'Sales Qualified' || leadRecord.status == 'Closing Deal') && (leadRecord.RecordTypeID == SalesLeadRecordTypeID || leadRecord.RecordTypeID == salesAssignLeadRcdTypeID || leadRecord.RecordTypeID == EloquaLeadRecordTypeID || leadRecord.RecordTypeID == marketingLeadRecordTypeID) && leadRecord.Partner_Company_Name__c!=null && (leadRecord.Lead_Value_Lead_Amount__c>100 && leadRecord.Lead_Value_Lead_Amount__c<25000) && !leadRecord.isConverted){
            
            if((leadRecord.status == 'Closing Deal') && (leadRecord.RecordTypeID == SalesLeadRecordTypeID || leadRecord.RecordTypeID == salesAssignLeadRcdTypeID || leadRecord.RecordTypeID == EloquaLeadRecordTypeID || leadRecord.RecordTypeID == marketingLeadRecordTypeID) && leadRecord.Partner_Company_Name__c!=null && (leadRecord.Lead_Value_Lead_Amount__c>100 && leadRecord.Lead_Value_Lead_Amount__c<25000) && !leadRecord.isConverted){
                Contact con = new Contact();
                con.Accountid = accountsMap.get(leadRecord.Company);
                con.FirstName = leadRecord.FirstName;
                con.LastName = leadRecord.LastName;
                con.MailingCountrycode = leadRecord.Countrycode;
                con.MailingStatecode = leadRecord.Statecode; 
          //    con.Phone = leadRecord.Phone_Country_Code__c;
          //    con.Mobile = leadRecord.Mobile_Country_Code__c;
                con.title = leadRecord.title;
                con.Contact_Job_Role__c = leadRecord.Job_Role__c;
                con.Preferred_Language__c = leadRecord.Preferred_Language__c;
                con.Contact_Status__c = leadRecord.Contact_Status__c;
                
                String leadOwnerId = leadRecord.OwnerId;
                System.debug('Lead Owner from Record '+leadRecord.OwnerId);
                if(!leadOwnerId.startsWith('00G'))
                {
                  con.OwnerId = leadRecord.OwnerId;
                }
                else
                {
                  con.OwnerId = currentUser;
                }
                
                System.debug('contact owner id: '+con.OwnerId);
                System.debug('lead owner id: '+leadRecord.OwnerId);
                contactsList.add(con);
            }
        }
        insert contactsList;
    }
    
    for(Contact con:contactsList){
        contactsMap.put(con.FirstName+con.LastName, con.id);
    }
    
    for (Lead lead: Trigger.new){
        system.debug('lead.RecordTypeID --> '+lead.RecordTypeID);
        system.debug('SalesLeadRecordTypeID --> '+SalesLeadRecordTypeID);
        system.debug('marketingLeadRecordTypeID --> '+marketingLeadRecordTypeID);
        system.debug('lead.status --> '+lead.status);
        system.debug('lead.isConverted --> '+lead.isConverted);
        
        //if((lead.status == 'Sales Qualified' || lead.status == 'Closing Deal') && (lead.RecordTypeID == SalesLeadRecordTypeID || lead.RecordTypeID == salesAssignLeadRcdTypeID || lead.RecordTypeID == EloquaLeadRecordTypeID || lead.RecordTypeID == marketingLeadRecordTypeID) && lead.Partner_Company_Name__c!=null && (lead.Lead_Value_Lead_Amount__c>100 && lead.Lead_Value_Lead_Amount__c<25000) && !lead.isConverted){
        
        if((lead.status == 'Closing Deal') && (lead.RecordTypeID == SalesLeadRecordTypeID || lead.RecordTypeID == salesAssignLeadRcdTypeID || lead.RecordTypeID == EloquaLeadRecordTypeID || lead.RecordTypeID == marketingLeadRecordTypeID) && lead.Partner_Company_Name__c!=null && (lead.Lead_Value_Lead_Amount__c>100 && lead.Lead_Value_Lead_Amount__c<25000) && !lead.isConverted){
             Database.LeadConvert leadsToConvert = new Database.LeadConvert();
             leadsToConvert.setLeadId(lead.Id);
             
             String leadOwnerId = lead.OwnerId;
             if(leadOwnerId.startsWith('00G'))
             {
                 leadsToConvert.setOwnerId(currentUser);
             }
             else
             {
                leadsToConvert.setOwnerId(lead.OwnerId);
                System.debug('Lead Owner Now: '+lead.OwnerId);
             }
             if(accountsMap != null && accountsMap.containsKey(lead.company)){
                leadsToConvert.setAccountId(accountsMap.get(lead.company));
                
             }
             if(contactsMap != null && contactsMap.containsKey(lead.firstname+lead.lastname)){
                leadsToConvert.setContactId(contactsMap.get(lead.firstname+lead.lastname));
                
             }
             leadsToConvert.setConvertedStatus('Converted');
             listOfLeadsToBeConverted.add(leadsToConvert);
         }
    }
    if (!listOfLeadsToBeConverted.isEmpty()){
        //convertLead method converts a lead into an account and contact, as well as (optionally) an opportunity. 
        List<Database.LeadConvertResult> lcr = Database.convertLead(listOfLeadsToBeConverted);
        List<ID> newOpp = new List<ID>();
        
        //Map to get Lead Id corresponding to Opportunity Id
        Map<ID,ID> leadOppMap = new Map<ID, ID>();
        for(Database.LeadConvertResult dlcr: lcr)
        {
          newOpp.add(dlcr.getOpportunityId());
          leadOppMap.put(dlcr.getOpportunityId(),dlcr.getLeadId());
        }
        
        List<Opportunity> newOpps= [Select Id, RecordTypeId, StageName, Amount from Opportunity where id in :newOpp];
        for(Opportunity opp: newOpps)
        {
          opp.RecordTypeID = AutoConvertRecordTypeID;
          opp.StageName='Closed - Won';
          opp.Amount=leadsMap.get(leadOppMap.get(opp.Id)).Lead_Value_Lead_Amount__c;
          opp.Reason_for_Win_Loss__c=leadsMap.get(leadOppMap.get(opp.Id)).Reason_Won_Loss_Rejected__c;
        }
        update newOpps;
        
        
    }
}
    catch(Exception e)
        {
            System.debug('Validation Message : '+e.getMessage());
        }
        
}
}