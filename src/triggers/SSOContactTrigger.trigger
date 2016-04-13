/**************************************************************************************************
* Name   : SSOContactTrigger
* Author : Dhruthi S, Mohammed Touseef Ahmed
* Date   : 18-Nov-2015
* Purpose: This trigger creates a SSO Workflow request on Contact creation
* ======================================
* = MODIFICATION HISTORY =
* ======================================
* DATE            AUTHOR                   CHANGE
* ----            ------                   ------
* 18-Nov-2015     Dhruthi S               Created
* 19-Nov-2015     Dhruthi S               Modified
***************************************************************************************************/
trigger SSOContactTrigger on Contact (before insert, after insert, before update, after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Contact');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        List<SSO_Workflow__c> ssoFlowList = new List<SSO_Workflow__c>();
        List<SSO_Workflow__c> ssoUpdateFlowList = new List<SSO_Workflow__c>();
        Record_Type__c partnerContactRecordType = Record_Type__c.getValues('Partner Contact');
        Map<Id,Double> accResellerMap = new Map<Id,Double>();
        Map<Id,Double> accDistiMap = new Map<Id,Double>();
        Map<Id,Boolean> accZISPMap = new Map<Id,Boolean>();
        Set<Id> accIdSet = new Set<Id>();
        List<Tool_Access_History__c> insertToolAccessHistory;
        if(Trigger.isBefore && Trigger.isInsert){
            Set<Id> accountSet = new Set<Id>();
            Map<Id,String> accPartnerStatusMap = new Map<Id,String>();
            for(Contact c : Trigger.New){
                if(c.RecordTypeId != null && c.RecordTypeId == partnerContactRecordType.Record_Type_Id__c)
                    accountSet.add(c.AccountId);
            }
            for(Account acc : [Select Id, Partner_Status__c, Is_ZISP__c from Account WHERE Id IN :accountSet]){
                accPartnerStatusMap.put(acc.Id, acc.Partner_Status__c);
                accZISPMap.put(acc.Id, acc.Is_ZISP__c);
            }
            for(Contact cont : Trigger.New){
                if(cont.Account_Type__c == 'Partner' && cont.RecordTypeId != null && cont.RecordTypeId == partnerContactRecordType.Record_Type_Id__c && !accZISPMap.get(cont.AccountId)){
                    system.debug('cont.Account.Partner_Status__c'+accPartnerStatusMap.get(cont.AccountId));
                    if(accPartnerStatusMap.containsKey(cont.AccountId) && accPartnerStatusMap.get(cont.AccountId) == 'Inactive')
                        cont.Contact_Status__c = 'Inactive';
                }
            }
        }
        if(Trigger.isAfter && Trigger.isInsert){
            // Get the account details
            for(Contact con : Trigger.New){
                accIdSet.add(con.AccountId);
            }
            // Fetch the Program Information for the associated accounts - for checking if the contact needs default access to Deal Reg
            for(Account acc : [Select Id, of_Active_Distributor__c, of_Active_Reseller__c, Is_ZISP__c FROM Account WHERE Id IN :accIdSet]){
                accResellerMap.put(acc.id, acc.of_Active_Reseller__c);
                accDistiMap.put(acc.Id, acc.of_Active_Distributor__c);
                accZISPMap.put(acc.Id, acc.Is_ZISP__c);
            }
            for(Contact c: Trigger.new){
                //Create a SSO Workflow record for user creation
                if(c.Account_Type__c == 'Partner' && c.RecordTypeId != null && c.RecordTypeId == partnerContactRecordType.Record_Type_Id__c && !accZISPMap.get(c.AccountId)){
                    SSO_Workflow__c ssoflow = new SSO_Workflow__c();
                    ssoflow.Related_Contact__c = c.Id;
                    ssoflow.Request_Source__c = 'Default';
                    ssoflow.Request_Type__c = 'Create User';
                    ssoflow.Process_Status__c ='Pending';
                    ssoFlowList.add(ssoflow);
                    //For Default Deal Registration Access
                    system.debug('Reseller-->'+accResellerMap.get(c.AccountId)+' Distributor-->'+accDistiMap.get(c.AccountId));
                    if(c.Partner_Administrator__c && (accResellerMap.get(c.AccountId) > 0 || accDistiMap.get(c.AccountId) > 0)){
                        SSO_Workflow__c ssoflowApp = new SSO_Workflow__c();
                        ssoflowApp.Related_Contact__c = c.Id;
                        ssoflowApp.Request_Source__c= 'Default';
                        ssoflowApp.Application_Name__c = system.Label.SSO_App_Deal_Registration;
                        ssoflowApp.Process_Status__c = 'Pending';
                        ssoflowApp.Request_Type__c = 'Application Grant Access';
                        ssoflowApp.Requested_Date__c = DateTime.now();
                        ssoFlowList.add(ssoflowApp);
                    }
                }
                //For Tool Access History
                if(c.Account_Type__c == 'Partner' && c.RecordTypeId != null && c.RecordTypeId == partnerContactRecordType.Record_Type_Id__c){
                    insertToolAccessHistory = new List<Tool_Access_History__c>();
                    if(c.Tool_Access__c != null){
                        Tool_Access_History__c tah = new Tool_Access_History__c();
                        tah.Contact__c = c.Id;
                        tah.New_Value__c = c.Tool_Access__c;
                        insertToolAccessHistory.add(tah);
                    }
                }
            }
            system.debug('before ssoFlowList-->'+ssoFlowList);
            try{
                if(ssoFlowList.size() > 0){
                    insert ssoFlowList;
                    system.debug('after ssoFlowList-->'+ssoFlowList);
                }
                if(insertToolAccessHistory.size() > 0){
                    insert insertToolAccessHistory;
                    system.debug('after insertToolAccessHistory-->'+insertToolAccessHistory);
                }
            }catch(Exception e){
                system.debug('Exception occurred:'+e.getMessage());
            }
        }
        
        if(Trigger.isBefore && Trigger.isUpdate){
            for(Contact cb: Trigger.new){
                system.debug('Trigger.OldMap.get(cb.Id).Admin_Access_Requested__c'+Trigger.OldMap.get(cb.Id).Admin_Access_Requested__c);
                system.debug('cb.Admin_Access_Requested__c'+cb.Admin_Access_Requested__c);
                if(Trigger.OldMap.get(cb.Id).Admin_Access_Requested__c != cb.Admin_Access_Requested__c && !cb.Admin_Access_Requested__c && cb.Partner_Administrator__c){
                    cb.Partner_Administrator__c = FALSE;
                    cb.Partner_Administartor_Role_Accepted__c = FALSE;
                }
            }
        }
        
        if(Trigger.isAfter && Trigger.isUpdate){
            Set<Id> accountIdSet = new Set<Id>();
            Set<Id> contactIdSet = new Set<Id>();
            Map<Id,String> accStatusMap = new Map<Id,String>();
            Map<Id,SSO_Workflow__c> conSSOFlowMap = new Map<Id,SSO_Workflow__c>();
            for(Contact c: Trigger.new){
                accountIdSet.add(c.AccountId);
                contactIdSet.add(c.Id);
            }
            for(Account a : [Select Id, Partner_Status__c, of_Active_Distributor__c, of_Active_Reseller__c, Is_ZISP__c from Account WHERE Id IN :accountIdSet]){
                accStatusMap.put(a.Id, a.Partner_Status__c);
                accResellerMap.put(a.id, a.of_Active_Reseller__c);
                accDistiMap.put(a.Id, a.of_Active_Distributor__c);
                accZISPMap.put(a.Id, a.Is_ZISP__c);
            }
            for(SSO_Workflow__c sfDeal : [Select Id, Application_Name__c, Related_Contact__c, Process_Status__c, Request_Source__c, Request_Type__c FROM SSO_Workflow__c WHERE Related_Contact__c IN :contactIdSet AND Application_Name__c = :System.Label.SSO_App_Deal_Registration]){
                conSSOFlowMap.put(sfDeal.Related_Contact__c, sfDeal);
            }
            for(Contact con : Trigger.new){
                Contact objOldCon = Trigger.oldMap.get(con.ID);
                if(con.Account_Type__c == 'Partner' && con.RecordTypeId != null && con.RecordTypeId == partnerContactRecordType.Record_Type_Id__c && accZISPMap.containsKey(con.AccountId) && !accZISPMap.get(con.AccountId) && con.User_Created__c &&
                   (con.Email != objOldCon.Email ||
                    con.FirstName != objOldCon.FirstName ||
                    con.LastName != objOldCon.LastName ||
                    con.MailingStreet != objOldCon.MailingStreet || 
                    con.MailingCity != objOldCon.MailingCity ||
                    con.MailingState != objOldCon.MailingState ||
                    con.MailingCountry != objOldCon.MailingCountry ||
                    con.MailingPostalCode != objOldCon.MailingPostalCode ||
                    con.Phone != objOldCon.Phone ||
                    con.MobilePhone != objOldCon.MobilePhone ||
                    con.Partner_Administrator__c != objOldCon.Partner_Administrator__c ||
                    con.Preferred_Language__c != objOldCon.Preferred_Language__c )){
                        SSO_Workflow__c ssoflowUpdate = new SSO_Workflow__c();
                        ssoflowUpdate.Related_Contact__c = con.Id;
                        ssoflowUpdate.Request_Source__c= 'Delegated';
                        ssoflowUpdate.Process_Status__c = 'Pending';
                        ssoflowUpdate.Request_Type__c = 'Update User';
                        ssoUpdateFlowList.add(ssoflowUpdate);
                    }
                
                //For Default Deal Registration Access
                system.debug('Reseller-->'+accResellerMap.get(con.AccountId)+' Distributor-->'+accDistiMap.get(con.AccountId));
                if(con.Account_Type__c == 'Partner' && con.RecordTypeId != null && con.RecordTypeId == partnerContactRecordType.Record_Type_Id__c && accZISPMap.containsKey(con.AccountId) && !accZISPMap.get(con.AccountId) && con.Contact_Status__c == 'Active' && 
                   con.Partner_Administrator__c != objOldCon.Partner_Administrator__c && con.Partner_Administrator__c && accResellerMap.containsKey(con.AccountId) && accDistiMap.containsKey(con.AccountId) &&
                   (accResellerMap.get(con.AccountId) > 0 || accDistiMap.get(con.AccountId) > 0)){
                       SSO_Workflow__c ssoflowApp;
                       if(conSSOFlowMap.containsKey(con.Id))
                           ssoflowApp = conSSOFlowMap.get(con.Id);
                       else
                           ssoflowApp = new SSO_Workflow__c();
                       ssoflowApp.Related_Contact__c = con.Id;
                       ssoflowApp.Request_Source__c= 'Default';
                       ssoflowApp.Application_Name__c = system.Label.SSO_App_Deal_Registration;
                       ssoflowApp.Process_Status__c = 'Pending';
                       ssoflowApp.Request_Type__c = 'Application Grant Access';
                       ssoflowApp.Requested_Date__c = DateTime.now();
                       ssoUpdateFlowList.add(ssoflowApp);
                   }
                
                //For deactivate requests
                if(con.Account_Type__c == 'Partner' && con.RecordTypeId != null && con.RecordTypeId == partnerContactRecordType.Record_Type_Id__c && accZISPMap.containsKey(con.AccountId) 
                    && !accZISPMap.get(con.AccountId) && con.Contact_Status__c != objOldCon.Contact_Status__c && 
                   (con.Contact_Status__c == 'Inactive' || con.Contact_Status__c == 'Deceased') && !con.Admin_raised_Deactivate_Request__c){
                       SSO_Workflow__c deacflow = new SSO_Workflow__c();
                       deacflow.Related_Contact__c = con.Id;
                       if(accStatusMap.get(con.AccountId) == 'Inactive')
                           deacflow.Request_Source__c = 'Bulk';
                       else
                           deacflow.Request_Source__c = 'PIC';
                       deacflow.Request_Type__c = 'Deactivate User';
                       deacflow.Process_Status__c = 'Approved';
                       ssoUpdateFlowList.add(deacflow);
                   }
                
                //For Tool Access History
                insertToolAccessHistory = new List<Tool_Access_History__c>();
                if(con.RecordTypeId != null && con.RecordTypeId == partnerContactRecordType.Record_Type_Id__c && con.Tool_Access__c != Trigger.OldMap.get(con.Id).Tool_Access__c){
                    Tool_Access_History__c tah = new Tool_Access_History__c();
                    tah.Contact__c = con.Id;
                    tah.Old_Value__c = Trigger.OldMap.get(con.Id).Tool_Access__c;
                    tah.New_Value__c = con.Tool_Access__c;
                    insertToolAccessHistory.add(tah);
                }
            }
            system.debug('ssoUpdateFlowList-->'+ssoUpdateFlowList);
            if(ssoUpdateFlowList.size() > 0)
                upsert ssoUpdateFlowList;
            if(insertToolAccessHistory.size() > 0)
                insert insertToolAccessHistory;
        }
    }
}