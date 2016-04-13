/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : kushal_soni01@infosys.com
Date        : 18-Feb-15 
Description : This trigger is written to assign Rejected Leads to 4 different queues on the basis of their Region.
Revision History 
Ver       Date        Author           Modification 
---       ---------   -----------      -------------------------
V0.1      18-Feb-15   Kushal Soni      Initial Code
***************************************************************/

trigger ZEBLead_AU_AssignQueueToRejectedLeads on Lead (after update){

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Lead');
    if(objTriggerDeactivate.IsTriggerActive__c){
    
    List<ID> leadIds = new List<ID>();
    
    for (Lead l: Trigger.new){
        if(l.Status == 'Rejected')
            leadIds.add(l.id);
    }
    if(ZEB_ReassignLeads.isRuleAlreadyCalled()==FALSE)
    //Calling the assign method of ZEB_ReassignLeads class which in turn will call the assignment rule to assign the Lead Owner.
      ZEB_ReassignLeads.assign(leadIds);    
}}