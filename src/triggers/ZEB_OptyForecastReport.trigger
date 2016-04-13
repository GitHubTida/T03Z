/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : skrishnamoorthy@salesforce.com
Date        : 09/02/15 
Description : 
1. isDelete - When opportunity is deleted, performing deletion of custom forecast revenue records for the corresponding Opportunity.

Ver       Date        Author                       Modification 
---       ---------   ----------------------       -------------------------
V0.1      09/02/15    Sreeram Krishnamoorthy       Initial Code
V0.2      12/02/15    Sreeram Krishnamoorthy       Removed checking for trigger deactivate switch and interface user. 
                                                   Any DML operation in Opportunity should be updated in clone object as well.
***************************************************************/

trigger ZEB_OptyForecastReport on Opportunity (before delete, after update, after insert) {
    list<OpportunityLineItemScheduleClone__c> lstOppLineItemScheduleClone = new list<OpportunityLineItemScheduleClone__c>();
    if (Trigger.isDelete){
        lstOppLineItemScheduleClone = [Select Id from OpportunityLineItemScheduleClone__c where Opportunity__c in: Trigger.old];

        if(lstOppLineItemScheduleClone.size()>0 && lstOppLineItemScheduleClone!=null){
            try{
                delete lstOppLineItemScheduleClone;
            }
            catch(Exception e){
                system.debug('Error Trgr: ZEB_OptyForecastReport - Delete : ' + e.getMessage());
            }
        }
    } // end (Trigger.isDelete)

    if (Trigger.isInsert){
        for (Opportunity opty :trigger.new){
            if (opty.Line_items__c <= 0){
                OpportunityLineItemScheduleClone__c tmp = new OpportunityLineItemScheduleClone__c();
                tmp.IDtoClone__c = opty.id;
                tmp.Type__c = 'Clone - Opportunity';
                lstOppLineItemScheduleClone.add(tmp);
            }
        }
        if(lstOppLineItemScheduleClone.size()>0 && lstOppLineItemScheduleClone!=null){
            try{
                upsert lstOppLineItemScheduleClone;
            }
            catch(Exception e){
                system.debug('Error Trgr: ZEB_OptyForecastReport - Upsert : ' + e.getMessage());
            }
        }
    } // end (Trigger.isInsert)
    
    if (Trigger.isUpdate){
        Set<Id> OptyIDsWithLine = new Set<Id>();
        Set<Id> CheckOptyIDsToDelete = new Set<Id>();
        for (Opportunity opty :trigger.new){
            if ((opty.Line_items__c <= 0) && ((Trigger.oldMap.get(opty.id).CloseDate != opty.CloseDate) || 
            (Trigger.oldMap.get(opty.id).TotalOpportunityQuantity != opty.TotalOpportunityQuantity) || 
            (Trigger.oldMap.get(opty.id).Amount != opty.Amount) || 
            (Trigger.oldMap.get(opty.id).Ownerid != opty.Ownerid) || 
            (Trigger.oldMap.get(opty.id).CurrencyIsoCode != opty.CurrencyIsoCode) ||
            (Trigger.oldMap.get(opty.id).Line_items__c > 0))){
                OpportunityLineItemScheduleClone__c tmp = new OpportunityLineItemScheduleClone__c();
                tmp.IDtoClone__c = opty.id;
                tmp.Type__c = 'Clone - Opportunity';
                lstOppLineItemScheduleClone.add(tmp);
            }

            if ((opty.Line_items__c > 0) && (Trigger.oldMap.get(opty.id).Line_items__c == 0)){
                CheckOptyIDsToDelete.add(opty.id);
            }
            
            if ((opty.Line_items__c > 0) && ((Trigger.oldMap.get(opty.id).CloseDate != opty.CloseDate) || (Trigger.oldMap.get(opty.id).ownerid != opty.ownerid)))
            {
                    OptyIDsWithLine.add(opty.id);
            }
        }
        list<OpportunityLineItem> lstLineItems = [select id from opportunitylineitem where opportunityid in :OptyIDsWithLine];
        if(lstLineItems.size()>0 && lstLineItems!=null){
            for (OpportunityLineItem Line :lstLineItems){
                OpportunityLineItemScheduleClone__c tmp = new OpportunityLineItemScheduleClone__c();
                tmp.IDtoClone__c = Line.id;
                tmp.Type__c = 'Clone - Line Item';
                lstOppLineItemScheduleClone.add(tmp);
            }
        }
        list<OpportunityLineItemScheduleClone__c> chkDelete = [select id from OpportunityLineItemScheduleClone__c where type__c = 'Opportunity' and Opportunity__c in :CheckOptyIDsToDelete];
        if(chkDelete.size()>0 && chkDelete!=null){
            try{
                delete chkDelete;
            }
            catch(Exception e){
                system.debug('Error deleting Opportunity clone records when Line items are created : ' + e.getMessage());
            }
        }

        if(lstOppLineItemScheduleClone.size()>0 && lstOppLineItemScheduleClone!=null){
            try{
                upsert lstOppLineItemScheduleClone;
            }
            catch(Exception e){
                system.debug('Error Trgr: ZEB_OptyForecastReport - Upsert : ' + e.getMessage());
            }
        }
    } // end Trigger.isUpdate
}