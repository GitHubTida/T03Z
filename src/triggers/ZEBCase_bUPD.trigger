/********************************************************************************
TRIGGER         : ZEBCase_bUPD
INSTRUCTIONS    : ------DISABLE IN CASE OF CASE BULK DATA UPDATE --------
PURPOSE         : Blank out some of the case fields if OLD Product Model is not equal to NEW Product Model.
CREATED BY      : Shakti Mehtani
CREATED DATE    : 05/21/2014 (MM/DD/YYYY)

--------------------------------------------------------------------------------
MODIFICATION HISTORY

MODIFICATION DATE   MODIFIED BY             REASON
9-JUL-2014          Joseph Guzon            Model should set additional Product Heirarchy values
17-JUL-2014         Joseph Guzon            Serial Number field is not blanked out when Prod Model 
                                            is set independent of the SN
18-JUL-2014         Shakti Mehtani          Added logic for Incrementing ZEB_Case_Status_Change_Count__c on STATUS change
08/18/2014          Shakti Mehtani          Added code for Disabling the trigger based on custom setting -> TriggerDeactivateSwitch__c
--------------------------------------------------------------------------------
*********************************************************************************/
trigger ZEBCase_bUPD on Case (before update) {

    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Case');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c && !ZEBUtility.IS_SERIAL_NO_LOOKUP_PERFORMED) {
        Case oldCaseObj;
        
        for(integer i =0; i < trigger.new.size(); i++) {
            oldCaseObj = trigger.oldMap.get(trigger.new[i].id);

            if(trigger.new[i].ZEB_Product_Model__c != oldCaseObj.ZEB_Product_Model__c) {
                trigger.new[i].ZEB_Product_Name__c = '';
                trigger.new[i].ZEB_Product_Description__c = '';
                trigger.new[i].ZEB_Item_Group__c = '';
                trigger.new[i].ZEB_Product_Item_UOM__c = '';
                trigger.new[i].ZEB_Item_Agile_Life_Cycle__c = '';
                
                //trigger.new[i].ZEB_Item_Product_Class__c = '';
                trigger.new[i].ZEB_Item_Product_Class__c = trigger.new[i].ZEB_Product_Class_Reference__c;
                
                trigger.new[i].ZEB_Item_Orderable_Flag__c = false;
                
                //trigger.new[i].ZEB_Item_Product_Sub_Family__c = '';
                trigger.new[i].ZEB_Item_Product_Sub_Family__c = trigger.new[i].ZEB_Product_Sub_Family_Reference__c;
                
                trigger.new[i].ZEB_Item_Serialized_Flag__c = false; 
                trigger.new[i].ZEB_Item_Status__c = ''; 
                trigger.new[i].ZEB_Item_Stock_Enabled_Flag__c = false;
                
                //trigger.new[i].ZEB_Product_Sub_Line__c = '';
                trigger.new[i].ZEB_Product_Sub_Line__c = trigger.new[i].ZEB_Product_Sub_Line_Reference__c;
                
                //trigger.new[i].ZEB_Product_Line__c = '';
                trigger.new[i].ZEB_Product_Line__c = trigger.new[i].ZEB_Product_Line_Reference__c;
                
                //trigger.new[i].ZEB_Product_Family__c = '';
                trigger.new[i].ZEB_Product_Family__c = trigger.new[i].ZEB_Product_Family_Reference__c;
                
                //Serial Number is no longer reset: JG 17-Jul-2014
                //trigger.new[i].ZEB_Serial_Number__c = '';
            }
            
            //Increment ZEB_Case_Status_Change_Count__c on STATUS change
            if(trigger.new[i].Status != oldCaseObj.Status) {
                System.debug('*********************************************** I AM HERE');
                trigger.new[i].ZEB_Case_Status_Change_Count__c += 1;
            }
        } 
        ZEBUtility.IS_SERIAL_NO_LOOKUP_PERFORMED = false;
         
        /******Case level time Counter UpdateLogic ****/
             
        list<Case> lstNewCase = new list<Case>();
        list<Case> lstOldCase = new list<Case>();
        list<Case> lstOldStatusChanged = new list<Case>();
        list<Case> lstNewStatusChanged = new list<Case>();
       
        for(Case objCase : trigger.new){
            Case objOldCase = Trigger.oldMap.get(objCase.ID);
            
           /*Case Owner is being changed */
           if(objCase.OwnerID  != objOldCase.OwnerID) {
                lstNewCase.add(objCase);
                lstOldCase.add(objOldCase); 
            }
            /*Case Owner is not being changed */
            else
            {
                if( (objCase.Status != objOldCase.Status) && ( objCase.Status == 'Pending Customer Response' || objCase.Status == 'Solution Provided' || objCase.Status == 'Closed' || objCase.Status == 'Customer No Response') ){
                    lstNewStatusChanged.add(objCase);
                }
                
                if( (objCase.Status != objOldCase.Status) && ( objOldCase.Status == 'Pending Customer Response' || objOldCase.Status == 'Solution Provided' || objOldCase.Status == 'Closed' || objOldCase.Status == 'Customer No Response') && ( objCase.Status != 'Pending Customer Response' || objCase.Status != 'Solution Provided' || objCase.Status != 'Closed' || objCase.Status != 'Customer No Response' ) ){
                
                    if ((objOldCase.Status == 'Solution Provided') && (objCase.Status == 'Closed')){
                        //do nothing
                    } else if ((objOldCase.Status == 'Closed') && (objCase.Status == 'Solution Provided')) {
                     	//do nothing   
                    } else if ((objOldCase.Status == 'Pending Customer Response') && (objCase.Status == 'Solution Provided')) {
                     	//do nothing
					} else if ((objOldCase.Status == 'Pending Customer Response') && (objCase.Status == 'Customer No Response')) {
                     	//do nothing
                    } else if ((objOldCase.Status == 'Customer No Response') && (objCase.Status == 'Closed')) {
                     	//do nothing
                    } else if ((objOldCase.Status == 'Customer No Response') && (objCase.Status == 'Pending Customer Response')) {
                     	//do nothing   
                    } else {
						lstOldStatusChanged.add(objCase);
                    }
                    
                    //lstOldStatusChanged.add(objCase);

                }
            }
        }
        
        if(lstNewCase.size()>0)
             ZEBCaseTriggerHandler.CaseOwnerChanged(lstOldCase,lstNewCase);
        
        if(lstNewStatusChanged.size()>0) {
            ZEBCaseTriggerHandler.CaseStatusChangedTo(lstNewStatusChanged);  
        }
        
        if(lstOldStatusChanged.size()>0) {
             ZEBCaseTriggerHandler.CaseStatusChangedFrom(lstOldStatusChanged);
        }
             
    /******Case level time Counter UpdateLogic ****/  
    
    }
}