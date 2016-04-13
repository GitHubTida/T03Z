/********************************************************************************
TRIGGER         : ZEBContact_bINS
INSTRUCTIONS    : NONE
PURPOSE         : 1) Copies the lookup objects on Contact to the standard Contact Mailing Address fields.
                  2) Assign default values to Contact's Do Not Call and Do Not Email fields
CREATED BY      : Shakti Mehtani
CREATED DATE    : 08/18/2014 (MM/DD/YYYY)
--------------------------------------------------------------------------------
MODIFICATION HISTORY
 
MODIFICATION DATE   MODIFIED BY             REASON
08/22/2014          Shakti Mehtani          Added logic for assigning default values to Contact's Do Not Call 
                                            and Do Not Email fields
--------------------------------------------------------------------------------
*********************************************************************************/
trigger ZEBContact_bINS on Contact (before insert, before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Contact');
    User userObj;
    //Execute if Contact Triggers are enabled for execution in the Custom Setting -> TriggerDeactivateSwitch__c
    if(objTriggerDeactivateSwitch.IsTriggerActive__c) {
       userObj = [SELECT Id, Name,Profile.name, Zebra_Organization__c, DefaultCurrencyIsoCode FROM User WHERE id = :UserInfo.getUserId()];
       if(Trigger.isInsert){

            map<String, ZEB_Country_Opt_Out__c> countryCode_zcooObj_map = new map<String, ZEB_Country_Opt_Out__c>();
            
            Contact oldContact;
            ZEB_Country_Opt_Out__c zcooObj;
            TriggerCommonMethods tcmObj = new TriggerCommonMethods();
            
            for(ZEB_Country_Opt_Out__c temp : [SELECT Country_Code__c, do_not_email__c, do_not_call__c FROM ZEB_Country_Opt_Out__c]) {
                countryCode_zcooObj_map.put(temp.country_code__c,temp); 
            }
             
            //Main
            for(Contact temp: trigger.new) {
                   if(ZEBUtility.isNotZebraInterfaceUser() ) {
                        if(userObj.Profile.name == 'Sales' ||
                           userObj.Profile.name == 'Sales Management' ||
                           userObj.Profile.name == 'Business Operations'){
                            if (temp.Phone == null) {
                                   temp.addError('Please enter the Phone Number');
                            }
                            if (temp.Email== null) {
                                   temp.addError('Please enter an email ID');
                            }
                        }
                }
                
                //Copy lookup objects on Contact to the standard Contact Mailing Address fields.
                 //Commented out vertex lookup fields by Zebra CRM Team as part of CRM Phase 1 Project
                /*if (temp.MailingCountryCode != null && temp.MailingCountryCode.equalsIgnoreCase('US') && temp.ZEB_Vertex_Zip__c != null && temp.ZEB_Vertex_Zip__c != '') {
                    tcmObj.contact_updateFields(temp);                  
                }*/
    
                //Assign default values to Contact's Do Not Call and Do Not Email fields            
                zcooObj = countryCode_zcooObj_map.get(temp.MailingCountryCode);
                if(zcooObj != null) {
                    temp.HasOptedOutOfEmail = zcooObj.do_not_email__c;
                    temp.DoNotCall = zcooObj.Do_Not_Call__c;
                }
            }
        }
        if(Trigger.isUpdate){
            for(Contact temp: trigger.new) {
                       if(ZEBUtility.isNotZebraInterfaceUser() ) {
                            if(userObj.Profile.name == 'Sales' ||
                               userObj.Profile.name == 'Sales Management' ||
                               userObj.Profile.name == 'Business Operations'){
                                if (temp.Phone == null) {
                                       temp.addError('Please enter the Phone Number');
                                }
                                if (temp.Email== null) {
                                       temp.addError('Please enter an email ID');
                                }
                            }
                    }
            }
        }       
        
        
        
        
    }
    
    
    
}