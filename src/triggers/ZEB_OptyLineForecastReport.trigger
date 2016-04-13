/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : skrishnamoorthy@salesforce.com
Date        : 09/02/15 
Description : 
1. isDelete - When opportunity line item is deleted, performing deletion of custom forecast revenue records for the corresponding Line Items.

Ver       Date        Author                       Modification 
---       ---------   ----------------------       -------------------------
V0.1      09/02/15    Sreeram Krishnamoorthy       Initial Code
V0.2      12/02/15    Sreeram Krishnamoorthy       Removed checking for trigger deactivate switch and interface user. 
                                                   Any DML operation in OpportunityLineItem should be updated in clone object as well.
***************************************************************/

trigger ZEB_OptyLineForecastReport on OpportunityLineItem (before delete, after insert, after update) {
     if (Trigger.isDelete){
        list<OpportunityLineItemScheduleClone__c> lstOppLineItemScheduleClone = new list<OpportunityLineItemScheduleClone__c>();
        Set<String> lineItemIds = new Set<String>();
        for (OpportunityLineItem line : Trigger.old){
            lineItemIds.add(line.id);
        }
        lstOppLineItemScheduleClone = [Select Id from OpportunityLineItemScheduleClone__c where OpportunityLineItemId__c in: lineItemIds];

        if(lstOppLineItemScheduleClone.size()>0 && lstOppLineItemScheduleClone!=null){
            try{
                delete lstOppLineItemScheduleClone;
            }
            catch(Exception e){
                system.debug('Error Trgr: ZEB_OptyLineForecastReport - Delete : ' + e.getMessage());
            }
        }
    } // end (Trigger.isDelete)

    if (Trigger.isInsert || Trigger.isUpdate){
        list<OpportunityLineItemScheduleClone__c> lstOptyForecastReportUpsert = new list<OpportunityLineItemScheduleClone__c>();
        for (OpportunityLineItem optyLine :trigger.new){
            OpportunityLineItemScheduleClone__c tmp = new OpportunityLineItemScheduleClone__c();
            tmp.IDtoClone__c = optyLine.id;
            tmp.Type__c = 'Clone - Line Item';
            lstOptyForecastReportUpsert.add(tmp);
        }

        if(lstOptyForecastReportUpsert.size()>0 && lstOptyForecastReportUpsert!=null){
            try{
                upsert lstOptyForecastReportUpsert;
            }
            catch(Exception e){
                system.debug('Error Trgr: ZEB_OptyLineForecastReport - Upsert : ' + e.getMessage());
            }
        }
    } // end (Trigger.isInsert || Trigger.isUpdate)
}