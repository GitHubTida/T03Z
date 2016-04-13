/**************************************************************
*    Copyright © 2015 Zebra Technologies. All rights reserved.
*    Author          : Nitin Shivshankara
*    Date            : 6/10/2015
*    Description     : This trigger shares the SCC record with Region Controller and RSM who approve the records
*    Revision History:
*    Ver       Date              Author                     Modification
*    ----      ---------         -----------                --------------------
*    1.0       6/10/2015       Nitin Shivashankara        Initial Creation with all the requirements
*********************************************************************************/

trigger ZEBSalesCreditClaimUpdateRequestorRSMandACShare on Sales_Credit_Claim__c (after insert, after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Sales Credit Claim');
    if(objTriggerDeactivate.IsTriggerActive__c){
    List<Sales_Credit_Claim__Share> salesCreditClaimShareList = new List<Sales_Credit_Claim__Share>();
    for (Sales_Credit_Claim__C scd : Trigger.new) {
        //Share the record to AC
        if (scd.Approving_AC__c != null && scd.Approving_AC__c != scd.ownerid) {
            Sales_Credit_Claim__Share scd_share = new Sales_Credit_Claim__Share();
            scd_share.ParentId = scd.Id;
            scd_share.AccessLevel = 'Edit';
            scd_share.UserOrGroupId = scd.Approving_AC__c;
            salesCreditClaimShareList.add(scd_share);
        }
        //Share the record to RSM
        if (scd.Approving_RSM__c != null && scd.Approving_RSM__c != scd.ownerid) {
            Sales_Credit_Claim__Share scd_share = new Sales_Credit_Claim__Share();
            scd_share.ParentId = scd.Id;
            scd_share.AccessLevel = 'Edit';
            scd_share.UserOrGroupId = scd.Approving_RSM__c;
            salesCreditClaimShareList.add(scd_share);
        }
    }

    try {
        if (salesCreditClaimShareList.size() > 0)
            insert salesCreditClaimShareList;
    } catch (Exception e) {
        trigger.new[0].addError('You are not allowed to Submit this claim. There is a problem with the approvers. Please work with your System Admin to get this claim added.');
    }
    }
}