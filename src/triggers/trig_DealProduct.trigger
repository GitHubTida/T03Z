/*******************************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Shanthi Latharani
Date        : 9-Sep-15
Description : The trigger is used to throw errormessage when the user try to delete the deal product for the submitted deal.
              
Revision History 
Ver       Date        Author             Modification 
---       ---------   -----------        -------------------------
V0.1      9-Sep-15   Shanthi Latharani    Initial Code
********************************************************************************/

trigger trig_DealProduct on DealProduct__c (before delete) {
   TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Deal Product');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    set<Id> dealIdSet = new set<Id>();
    for(DealProduct__c dp : Trigger.old){
        dealIdSet.add(dp.Deal_Registration__c);
    }

    //Querry the submitted deal registration
    Integer sizeaccount=[select count() from Deal_Registration__c where id in :dealIdSet And Approval_Status__c <> 'New'];
     User u = [select Profile.Name from user where id=:userinfo.getuserid()];
    if(sizeaccount == 1 && (u.Profile.Name!='Channel Administrator' && u.Profile.Name!='System Administrator'  && u.Profile.Name!='Channel Business Operations' && u.Profile.Name!='MCC and PIC')){
        for(DealProduct__c dp : Trigger.old){ 
            //Throw the error if the user try to delete the  deal product for the submitted deal.
           //dp.addError('<hr/><br/><br/><span style=\" color:crimson;font-weight: bold; font-size: 8pt;\">Record Locked: Once a deal is submitted you cannot add/edit/delete products.</span> <br/>',false); 
             dp.addError('<hr/><br/><br/><span style=\" color:crimson;font-weight: bold; font-size: 8pt;\">'+Label.DR_Redirect_Extension_Error+'</span> <br/>',false); 
            
        }
    }
    }
}