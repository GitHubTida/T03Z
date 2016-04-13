/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : kushal_soni01@infosys.com
Date        : 06-Apr-15
Description : This trigger is written to update Theater, Region and Sub-Region based on Country
Revision History
Ver       Date        Author           Modification
---       ---------   -----------      -------------------------
V0.1      06-Apr-15   Kushal Soni      Initial Code
V0.2      07-Apr-15   Kushal Soni      Added Country Code in the custom settings and modified code to get country on the basis of country code
 ***************************************************************/
trigger ZEBLead_BIBU_UpdateFieldsBasedOnCountry on Lead (before insert, before update) {

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Lead');
    if(objTriggerDeactivate.IsTriggerActive__c){
    // Map to collect custom settings values for Countries
    Map<String,Lead_Countries__c> leadCountry = Lead_Countries__c.getAll();

    for(Lead newLeads: Trigger.new){
        // Checking if Lead Country is present in the custom setting
        if(newLeads.CountryCode!=null && leadCountry.containsKey(newLeads.CountryCode)){
            Lead_Countries__c countries = leadCountry.get(newLeads.CountryCode);
            newLeads.Theater__c = countries.Theater__c;
            newLeads.Region__c = countries.Region__c;
            newLeads.Sub_Region__c = countries.Sub_Region__c;
        }
    }
}
}