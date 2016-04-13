/**************************************************************************************************
 * Name   : ZEBPMICalloutTrigger
 * Author : Nitin Shivashankara
 * Date   : 05-Nov-2015
 * Purpose: This trigger makes a web service callout to Siebel via Informatica
 * ======================================
 * = MODIFICATION HISTORY =
 * ======================================
 * DATE            AUTHOR                   CHANGE
 * ----            ------                   ------
 * 05-Nov-2015     Nitin Shivashankara      Created
 ***************************************************************************************************/

trigger ZEBPMICalloutTrigger on Program_Membership_Information__c (after insert, before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Partner Program Membership');
    List<Program_Membership_Information__c> insertNewPMIList = new List<Program_Membership_Information__c>();
    Map<String, PartnerProgramTierCombination__c> programNameMap = PartnerProgramTierCombination__c.getAll();
    boolean insertPMI = true;
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        if(ZEBUtility.isNotZebraInterfaceUser() ) {
            List<String> pmiIdList = new List<String>();
            if(Trigger.isInsert){
                for(Program_Membership_Information__c pmi: trigger.new){
                    if(!pmi.Updated_by_Certification_Batch__c)
                        pmiIdList.add(pmi.Id);
                }
                ZEBUtility.inFutureCalloutContext = true;
                if(pmiIdList.size() > 0)
                    ZEBWebServiceCalloutFuture.createSFDCtoSiebelPMIFuture(pmiIdList);
            }
            if(Trigger.isupdate){
                if(!ZEBUtility.inFutureCalloutContext){
                    for(Program_Membership_Information__c pmi: trigger.new){
                        System.debug('####Value of checkbox iss'+pmi.Updated_by_Certification_Batch__c);
                        if(!pmi.Updated_by_Certification_Batch__c){
                            if(pmi.Tier_Level__c != Trigger.oldMap.get(pmi.Id).Tier_Level__c){
                                if(programNameMap.containsKey(pmi.Partner_Program_Name__c)){
                                    Set<String> allowableTierValuesSet = new Set<String>();
                                    if(programNameMap.get(pmi.Partner_Program_Name__c).Allowable_Tier_Values__c == null)
                                        allowableTierValuesSet.add('');
                                    else
                                        allowableTierValuesSet.addAll(programNameMap.get(pmi.Partner_Program_Name__c).Allowable_Tier_Values__c.split(','));
                                    if(!(pmi.Tier_Level__c == null && allowableTierValuesSet.contains('')) && !allowableTierValuesSet.contains(pmi.Tier_Level__c)){
                                        insertPMI = false;
                                        pmi.addError('This Program and Tier combination is not allowed.');
                                    } else{
                                        insertPMI = true;
                                    }
                                } if(insertPMI){
                                    Program_Membership_Information__c pmiInsert = new Program_Membership_Information__c();
                                    pmiInsert.Account__c = pmi.Account__c;
                                    pmiInsert.Category__c = pmi.Category__c;
                                    pmiInsert.Membership_Activation_Date__c = system.now();
                                    pmiInsert.Partner_Program__c = pmi.Partner_Program__c;
                                    pmiInsert.Purchasing_Method__c = pmi.Purchasing_Method__c;
                                    pmiInsert.Status__c = pmi.Status__c;
                                    pmiInsert.Member_Status__c = 'Current Member';
                                    pmiInsert.Tier_Level__c = pmi.Tier_Level__c;
                                    pmiInsert.RecordTypeId = pmi.RecordTypeId;
                                    pmiInsert.Tier_Change__c = true;
                                    pmiInsert.Expiration_Date__c = pmi.Expiration_Date__c;
                                    insertNewPMIList.add(pmiInsert);

                                    pmi.Tier_Level__c = Trigger.oldMap.get(pmi.Id).Tier_Level__c;
                                    pmi.Member_Status__c = 'Expired';
                                    pmi.Membership_End_Date__c = system.now();
                                    pmiIdList.add(pmi.Id);
                                }
                            }
                            else{
                                pmiIdList.add(pmi.Id);
                            }
                        }
                    }
                    if(pmiIdList.size() > 0)
                        ZEBWebServiceCalloutFuture.createSFDCtoSiebelPMIFuture(pmiIdList);
                }
            }
            if(insertNewPMIList.size() > 0)
                insert insertNewPMIList;
        }
    }
}