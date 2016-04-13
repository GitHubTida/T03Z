/**************************************************************************************************
* Name   : ZEBPartnerContactCalloutTrigger
* Author : Sujata Das, Nitin Shivashankara
* Date   : 18-Nov-2015
* Purpose: This trigger makes a web service callout to Siebel via Informatica
* ======================================
* = MODIFICATION HISTORY =
* ======================================
* DATE            AUTHOR                   CHANGE
* ----            ------                   ------
* 18-Nov-2015     Sujata Das               Created
* 18-Nov-2015     Nitin Shivashankara      Created
* 20-Nov-2015     Dhruthi S                Modified the code to trigger only Siebel Related Attributes are changed
***************************************************************************************************/
trigger ZEBPartnerContactCalloutTrigger on Contact(after insert, after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Contact');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        if(ZEBUtility.isNotZebraInterfaceUser() ) {
            List<String> contactIdList = new List<String>();
            Map<Id,String> conToSiebelRowIdMap = new Map<Id,String>();
            for(Contact c : [SELECT Id,Account.Siebel_Row_Id__c FROM Contact WHERE Id IN :Trigger.new]){
            conToSiebelRowIdMap.put(c.Id, c.Account.Siebel_Row_Id__c);
            } 
            if(Trigger.isInsert){
                for(Contact contact : Trigger.new) {
                if(contact.RecordTypeId == Record_Type__c.getInstance('Partner Contact').Record_Type_Id__c && conToSiebelRowIdMap.containsKey(contact.Id)
                && conToSiebelRowIdMap.get(contact.Id) != null)
                    contactIdList.add(contact.id);
                }
                ZEBUtility.inFutureCalloutContext = true;
                ZEBWebServiceCalloutFuture.createSFDCtoSiebelContactFuture(contactIdList);
            }
            if(Trigger.isUpdate){
                system.debug('CHekc');
                system.debug('CHekc'+ ZEBUtility.inFutureCalloutContext);

                if(!ZEBUtility.inFutureCalloutContext){
                    for(Contact contact : Trigger.new) {
                        system.debug('CHekc'+ Trigger.OldMap.get(contact.Id).Contact_Ping_ZUID__c);
                        system.debug('CHekc'+ contact.Contact_Ping_ZUID__c);
                        system.debug('CHekc'+ contact.RecordTypeId);
                        system.debug('CHekc'+ contact.RecordTypeId);
                        system.debug('CHekc'+ contact.User_Created__c);
                        system.debug('CHekc'+ Trigger.OldMap.get(contact.Id).User_Created__c);
                        system.debug('CHekc'+ conToSiebelRowIdMap.containsKey(contact.Id));
                        system.debug('CHekc'+ Record_Type__c.getInstance('Partner Contact').Record_Type_Id__c);
                        system.debug('CHekc'+ conToSiebelRowIdMap.get(contact.Id));

                        if(contact.RecordTypeId == Record_Type__c.getInstance('Partner Contact').Record_Type_Id__c && 
                        conToSiebelRowIdMap.containsKey(contact.Id) && conToSiebelRowIdMap.get(contact.Id) != null &&
                        (Trigger.OldMap.get(contact.Id).AIT_Contact_ID__c != contact.AIT_Contact_ID__c ||
                        Trigger.OldMap.get(contact.Id).MobilePhone != contact.MobilePhone ||
                        Trigger.OldMap.get(contact.Id).Notes__c != contact.Notes__c ||
                        Trigger.OldMap.get(contact.Id).Department != contact.Department ||
                        Trigger.OldMap.get(contact.Id).Email != contact.Email ||
                        Trigger.OldMap.get(contact.Id).Fax != contact.Fax ||
                        Trigger.OldMap.get(contact.Id).FirstName != contact.FirstName ||
                        Trigger.OldMap.get(contact.Id).Title != contact.Title ||
                        Trigger.OldMap.get(contact.Id).LastName != contact.LastName ||
                        Trigger.OldMap.get(contact.Id).Salutation != contact.Salutation ||
                        Trigger.OldMap.get(contact.Id).Contact_Status__c != contact.Contact_Status__c ||
                        Trigger.OldMap.get(contact.Id).DoNotCall != contact.DoNotCall ||
                        Trigger.OldMap.get(contact.Id).HasOptedOutOfEmail != contact.HasOptedOutOfEmail ||
                        Trigger.OldMap.get(contact.Id).HasOptedOutOfFax != contact.HasOptedOutOfFax ||
                        Trigger.OldMap.get(contact.Id).Phone != contact.Phone ||
                        Trigger.OldMap.get(contact.Id).Preferred_Language__c != contact.Preferred_Language__c ||
                        Trigger.OldMap.get(contact.Id).Partner_Administrator__c != contact.Partner_Administrator__c ||
                        Trigger.OldMap.get(contact.Id).Primary_Role__c != contact.Primary_Role__c ||
                        Trigger.OldMap.get(contact.Id).MailingStreet != contact.MailingStreet ||
                        Trigger.OldMap.get(contact.Id).MailingCity != contact.MailingCity ||
                        Trigger.OldMap.get(contact.Id).MailingStateCode != contact.MailingStateCode ||
                        Trigger.OldMap.get(contact.Id).MailingCountry != contact.MailingCountry ||
                        Trigger.OldMap.get(contact.Id).MailingCountryCode != contact.MailingCountryCode ||
                        Trigger.OldMap.get(contact.Id).Secondary_Role__c != contact.Secondary_Role__c ))
                            contactIdList.add(contact.id);
                    }
                    ZEBUtility.inFutureCalloutContext = true;
                    if(contactIdList.size() > 0)
                        ZEBWebServiceCalloutFuture.createSFDCtoSiebelContactFuture(contactIdList);
                }
            }
        }
    }
}