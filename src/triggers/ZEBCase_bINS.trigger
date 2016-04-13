/********************************************************************************
TRIGGER         : ZEBCase_bINS
INSTRUCTIONS    : ------ DISABLE IN CASE OF CASE BULK DATA UPLOAD --------
PURPOSE         :   1) If Case's Owner = Context User then update Case's BusinessHours related to the country of Context User. 
                    2) Updating Case's Organization to that of Context User's Organization.     
                    3) Updating ZEB_Affected_Region__c based on the Case's Account.         
CREATED BY      : Joseph Guzon
CREATED DATE    : 04/25/2014 (MM/DD/YYYY)
--------------------------------------------------------------------------------
MODIFICATION HISTORY
 
MODIFICATION DATE   MODIFIED BY             REASON
06/04/2014          Shakti Mehtani          Added logic for updating Case's Org. to that of Context User's Org.
06/05/2014          Shakti Mehtani          Updated ZEB_Affected_Region__c based on the Case's Account. 
28-Jul-2014         Joseph Guzon            Added code to pull in additional prod hierarchy values when a case
                                            is created and a product model is added during case creation
08/18/2014          Shakti Mehtani          Added code for Disabling the trigger based on custom setting -> TriggerDeactivateSwitch__c 
09/01/2014          Shakti Mehtani          Added logic for making Business Hours Dynamic    
09/08/2014          Shakti Mehtani          Added logic for handling Context User of type Zebra Tech Support.  
09/12/2014          Shakti Mehtani          Added logic to handle situation when Case's Account Id = NULL                                    
--------------------------------------------------------------------------------
*********************************************************************************/
trigger ZEBCase_bINS on Case (before insert) {
    
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Case');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){ 
    
        list<User> userList;
        map<id,string> accId_accOrg_map;
        map<string,id> BHName_BHId_map = new map<string,id>();
        map<id,id> contactId_accId_map = new map<id,id>();
        set<id> tempIdSet;
        set<id> temp2IdSet;
        TS_Business_Hours__c tsBHObj;
        EmailToCaseAddOns__c e2c_CS_Obj;
        User usrObj;
        Id accId;
        string tempStr;
        string BHName;
        string defaultBHName;
        string ZEBTechSupportUsrName = 'Zebra Tech Support';
        //Added by Saurabh Makhija on 4 Nov-14
        list<Case> lstCases;
        
        try {
            //Get Context User's user record
            usrObj = [select Id, Name, CountryCode, Zebra_Organization__c from User where Id = :UserInfo.getUserId()];

            if(!usrObj.Name.equalsIgnoreCase(ZEBTechSupportUsrName)) {
                try {
                    tsBHObj = [SELECT Name FROM TS_Business_Hours__c WHERE country_code__c = :usrObj.CountryCode];
                } catch(Exception e) {
                    tsBHObj = [SELECT Name FROM TS_Business_Hours__c WHERE country_code__c = 'Default'];
                }
                BHName = tsBHObj.Name;
            }
            
            for(BusinessHours temp : [SELECT Id, Name, isDefault FROM BusinessHours]) {
                BHName_BHId_map.put(temp.Name,temp.Id);
                if(temp.IsDefault)  defaultBHName = temp.Name;
            }
            
            tempIdSet = new set<id>();
            temp2IdSet = new set<id>();
            accId_accOrg_map = new map<id,string>();
            
            //Added by Saurabh Makhija on 4 Nov-14
             lstCases = new list<Case>();
        
             
            for(Case c: Trigger.new) {
                system.debug('**************************************************************************** Contact ID:' + c.ContactId);
                system.debug('**************************************************************************** Account ID:' + c.AccountId);
                if(c.AccountId != null) {
                    tempIdSet.add(c.AccountId);
                //Added - Shakti Mehtani 09/12/2014
                } else {
                    system.debug('sharis inside else');
                    temp2IdSet.add(c.ContactId);
                }
                     
                system.debug('**************************************************************************** c.Contact.AccountId:' + c.Contact.AccountId);
                
                //Added by Saurabh Makhija on 4 Nov-14
                lstCases.add(c);
            }
            system.debug('sharis temp2IdSet = ' + temp2IdSet);
            
            for(Contact temp : [SELECT accountId FROM Contact WHERE id = :temp2IdSet]) {
                contactId_accId_map.put(temp.id,temp.accountId);
                system.debug('inside contact   temp.AccountId = ' + temp.AccountId);
                tempIdSet.add(temp.AccountId);
            }
            
            for(Account temp : [SELECT id, Organization__c FROM Account WHERE id = :tempIdSet]) {
                if(temp.Organization__c != null)    accId_accOrg_map.put(temp.id, temp.Organization__c);
            } 
            
            
            system.debug('**************************************************************************** tempIdSet:' + tempIdSet);
            system.debug('**************************************************************************** accId_accOrg_map:' + accId_accOrg_map);
            
            for(Case c: Trigger.new) {
                
                //If Case's Owner = Context User then update Case's BusinessHours related to the country of Context User. 
                if(c.ownerId == usrObj.id) {
                    
                    system.debug('************************************ MAIN BUS HOURS SECTION********************************************************');
                    
                    //Context User != Zebra Tech Support : meaning user is a real user creating the case via the UI
                    if(!usrObj.Name.equalsIgnoreCase(ZEBTechSupportUsrName)) {
                        
                        system.debug('************************************ User is not Email-to-Case ********************************************************');
                                                                        
                        if (usrObj.CountryCode == null || usrObj.CountryCode == '') {
                            if(BHName_BHId_map.containsKey('Default'))  c.BusinessHoursId = BHName_BHId_map.get('Default');
                            else c.BusinessHoursId = BHName_BHId_map.get(defaultBHName);
    
                        } else {
                            system.debug('************************************ Current User has Country Code value  ********************************************************');
                            if(BHName_BHId_map.containsKey(BHName)) c.BusinessHoursId = BHName_BHId_map.get(BHName);
                            else c.BusinessHoursId = BHName_BHId_map.get(defaultBHName);
                        }
                        
                    //Context User = Zebra Tech Support
                    } else {
                        
                        e2c_CS_Obj = EmailToCaseAddOns__c.getValues(c.origin);
                        if(e2c_CS_Obj.Case_Business_Hours__c != null && e2c_CS_Obj.Case_Business_Hours__c != '') {
                            if(BHName_BHId_map.containsKey(e2c_CS_Obj.Case_Business_Hours__c)) c.BusinessHoursId = BHName_BHId_map.get(e2c_CS_Obj.Case_Business_Hours__c);
                            else c.BusinessHoursId = BHName_BHId_map.get(defaultBHName);
                        }
                    }
                }
                
                system.debug('************************************ END MAIN SECTION ********************************************************');
                
                if(usrObj.Name.equalsIgnoreCase(ZEBTechSupportUsrName)) {
                    if(e2c_CS_Obj != null && e2c_CS_Obj.Case_Organization__c != null && e2c_CS_Obj.Case_Organization__c != '')
                        c.case_organization__c = e2c_CS_Obj.Case_Organization__c;
                }
                
                
                /*Modified by JG 4-Sep-2014*/
                /*Modified By Shakti Mehtani 09/08/2014*/
                
                //Context User = Zebra Tech Support
                if(usrObj.Name.equalsIgnoreCase(ZEBTechSupportUsrName)) {
                    //Set Case's Org based upon Case's Origin
                    if(e2c_CS_Obj != null && e2c_CS_Obj.Case_Organization__c != null && e2c_CS_Obj.Case_Organization__c != '')
                        c.case_organization__c = e2c_CS_Obj.Case_Organization__c;
                        
                //Context User != Zebra Tech Support
                } else {
                    //Set Case's Organization = Context User's Organization
                    if(usrObj.Zebra_Organization__c == null || usrObj.Zebra_Organization__c == '')
                        c.case_organization__c = 'Default Organization';
                    else
                        c.case_organization__c = usrObj.Zebra_Organization__c;
                }
                
                //Update Case's ZEB_Affected_Region__c based on the Case's Account
                
                //Added - Shakti Mehtani 09/12/2014
                if(c.AccountId != null)    accId = c.AccountId;
                else    accId = contactId_accId_map.get(c.contactId);
                //End - Shakti Mehtani 09/12/2014

                 system.debug('sharis accOrg = ' + accId_accOrg_map.get(accId));

                if(accId_accOrg_map.containsKey(accId)) {
                    tempStr = accId_accOrg_map.get(accId);
        
                    if(tempStr.equalsIgnoreCase('Zebra NALA'))          c.ZEB_Affected_Region__c = 'NALA';
                    else if(tempStr.equalsIgnoreCase('Zebra EMEA'))     c.ZEB_Affected_Region__c = 'EMEA';
                    else if(tempStr.equalsIgnoreCase('Zebra APAC USD')||tempStr.equalsIgnoreCase('Zebra APAC RMB')) c.ZEB_Affected_Region__c = 'APAC';
                    //else if(tempStr.equalsIgnoreCase('Zebra APAC RMB')) c.ZEB_Affected_Region__c = 'APAC RMB';
                    
                }
                
                //Add enriched Product Model data, JG: 28-Jul-2014
                // Modified By : Shakti Mehtani 2014/09/01
                 if(c.ZEB_Product_Model__c != null){
                    c.ZEB_Item_Product_Class__c         = c.ZEB_Product_Class_Reference__c;            
                    c.ZEB_Product_Line__c               = c.ZEB_Product_Line_Reference__c;
                    c.ZEB_Product_Sub_Line__c           = c.ZEB_Product_Sub_Line_Reference__c;            
                    c.ZEB_Item_Product_Sub_Family__c    = c.ZEB_Product_Sub_Family_Reference__c;
                    c.ZEB_Product_Family__c             = c.ZEB_Product_Family_Reference__c;
                }        
                
            }
            
             /******Case Time Calculation Logic****/
               ZEBCaseTriggerHandler.calculateActiveSupportLevelDates(lstCases);
            /****************************************/
            
            
        
        } catch(Exception e) {
            System.debug('ZEBCase_bINS ERROR : Context User\'s user record not found.');
        }
    }
    

}