/********************************************************************************
 * Trigger on Contact that copies the lookup objects on Contact to the standard
 * Contact Mailing Address fields
 * Created JG, 20-May-2014
 ********************************************************************************/
trigger ZEBSetContactVertex on Contact (before update, before insert) {
/*****
    if (Trigger.isUpdate) {    
        
        //Set standard Mailing fields using the vertex lookup fields
        //Check to see if the custom Vertex field changed. If it did, then
        //write the values from Vertex lookup object into the Contact Mailing address
        for(Contact zec: Trigger.new) {        

            Contact oldcontact = Trigger.oldMap.get(zec.ID);
            
            if (zec.ZEB_Postal_Code__c != oldcontact.ZEB_Postal_Code__c) {
                
                zec.MailingCity = zec.ZEB_VertexCity__c;
                zec.MailingStateCode = zec.ZEB_Vertex_State__c;
                zec.MailingPostalCode = zec.ZEB_Vertex_Zip__c; 

            }

        }
    }
    

    if (Trigger.isInsert) {    
        //Set standard Mailing fields using the vertex lookup fields
        for(Contact znc: Trigger.new) {
            
            if (znc.MailingCountryCode == 'US') {
                
                if (znc.ZEB_Vertex_Zip__c == null || znc.ZEB_Vertex_Zip__c == ''){
                    //do nothing
                    //System.debug('========= Inside IF Condition =========');
                }
                else {
                    znc.MailingCity = znc.ZEB_VertexCity__c;
                    znc.MailingStateCode = znc.ZEB_Vertex_State__c;
                    znc.MailingPostalCode = znc.ZEB_Vertex_Zip__c;                    
                }

            }
        }
    
    }
*****/    
}