/********************************************************************************
TRIGGER         : ZEBContact_bUPD
INSTRUCTIONS    : NONE
PURPOSE         : 1) Copies the lookup objects on Contact to the standard Contact Mailing Address fields.
CREATED BY      : Shakti Mehtani
CREATED DATE    : 08/18/2014 (MM/DD/YYYY)
--------------------------------------------------------------------------------
MODIFICATION HISTORY
 
MODIFICATION DATE   MODIFIED BY             REASON
--------------------------------------------------------------------------------
*********************************************************************************/
trigger ZEBContact_bUPD on Contact (before update) {
    /*
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Contact');

    //Execute if Contact Triggers are enabled for execution in the Custom Setting -> TriggerDeactivateSwitch__c
    if(objTriggerDeactivateSwitch.IsTriggerActive__c)   {
        Contact oldContact;
        TriggerCommonMethods tcmObj = new TriggerCommonMethods();
        for(Contact temp: trigger.new) {
            if(trigger.oldMap != null)  oldContact = trigger.oldMap.get(temp.id);
            if (temp.ZEB_Postal_Code__c != oldContact.ZEB_Postal_Code__c){
                tcmObj.contact_updateFields(temp);                  
            }
        }
    }*/
}