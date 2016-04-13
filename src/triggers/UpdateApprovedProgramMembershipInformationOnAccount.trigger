/*
 * File Name     : UpdateApprovedProgramMembershipInformationOnAccount
 * Description   : This trigger updates the account with approved/accepted Program Membership details
 * @author       : Nitin Shivashankara
 *
 * Modification Log
 * =============================================================================
 *   Ver     Date         Author                 Modification
 *------------------------------------------------------------------------------
 *   1.0     30-Sep-15    Nitin Shivashankara    Initial Creation
     1.1     30-Nov-15    Sujata Das                Updates
     1.2     07-Jan-15    Dhruthi S              Updated the code to populate Partner Program Membership and Partner Program Product Specialization of Account
 */
trigger UpdateApprovedProgramMembershipInformationOnAccount on Program_Membership_Information__c (after insert, after update){
    List<Id> accountIdList = new List<Id>();
    List<Account> accountList = new List<Account>();
    Map<Id,Set<String>> accountIdProgramMembershipMap = new Map<Id,Set<String>>();
    Map<Id,String> accPMIMap = new Map<Id,String>();
    Map<Id,String> accPMISpecializationMap = new Map<Id,String>();
    Map<String, Record_Type__c> recordTypeSettings = Record_Type__c.getAll();
    for(Program_Membership_Information__c progMemInfo : Trigger.new){
        // if condition modified - when status is expired PMI field of account should be updated
        if((progMemInfo.Member_Status__c != 'Expired' || (progMemInfo.Member_Status__c != Trigger.oldMap.get(progMemInfo.Id).Member_Status__c && progMemInfo.Member_Status__c == 'Expired')) && progMemInfo.RecordTypeId != recordTypeSettings.get('Certified Product').Record_Type_Id__c){
            
            accountIdList.add(progMemInfo.Account__c);
            String programNameLevel = progMemInfo.Partner_Program_Name__c+((progMemInfo.Tier_Level__c != null)?','+progMemInfo.Tier_Level__c:'');
            if(accountIdProgramMembershipMap.containsKey(progMemInfo.Account__c)){
                Set<String> tempSet = accountIdProgramMembershipMap.get(progMemInfo.Account__c);
                tempSet.add(programNameLevel);
                accountIdProgramMembershipMap.put(progMemInfo.Account__c,tempSet);
            }else{
                Set<String> tempSet = new Set<String>();
                tempSet.add(programNameLevel);
                accountIdProgramMembershipMap.put(progMemInfo.Account__c,tempSet);
            }
        }
    }
    if(accountIdList.size() > 0){
        List<Program_Membership_Information__c> programMembershipList = [SELECT Id,Partner_Program_Name__c,Member_Status__c,Tier_Level__c,Purchasing_Method__c,RecordTypeId,Account__c
                                                                         FROM Program_Membership_Information__c
                                                                         WHERE Account__c in :accountIdList
                                                                         AND Member_Status__c != 'Expired'
                                                                         AND RecordTypeId != :recordTypeSettings.get('Certified Product').Record_Type_Id__c];
        for(Program_Membership_Information__c progMemInfo : programMembershipList){
            if(progMemInfo.Member_Status__c != 'Expired'){
                String programNameLevel = progMemInfo.Partner_Program_Name__c+((progMemInfo.Tier_Level__c != null)?','+progMemInfo.Tier_Level__c:'');
                if(accountIdProgramMembershipMap.containsKey(progMemInfo.Account__c)){
                    Set<String> tempSet = accountIdProgramMembershipMap.get(progMemInfo.Account__c);
                    tempSet.add(programNameLevel);
                    accountIdProgramMembershipMap.put(progMemInfo.Account__c,tempSet);
                }else{
                    Set<String> tempSet = new Set<String>();
                    tempSet.add(programNameLevel);
                    accountIdProgramMembershipMap.put(progMemInfo.Account__c,tempSet);
                }
            }
            //Added By Dhruthi to update Partner Program Membership and Partner Program Product Specialization in Account
            String prog = '';
            if(progMemInfo.Purchasing_Method__c == 'Direct') prog = 'Buy Direct ';
            else if(progMemInfo.Purchasing_Method__c == 'Indirect') prog = 'Buy Indirect ';
            if(progMemInfo.Tier_Level__c != null && progMemInfo.Tier_Level__c != '') prog = prog + progMemInfo.Tier_Level__c + ' ';
            prog = prog + progMemInfo.Partner_Program_Name__c;
            if(accPMIMap.containsKey(progMemInfo.Account__c) && progMemInfo.RecordTypeId == recordTypeSettings.get('Program').Record_Type_Id__c)
                accPMIMap.put(progMemInfo.Account__c, accPMIMap.get(progMemInfo.Account__c) + '; '+ prog);
            else if(!accPMIMap.containsKey(progMemInfo.Account__c) && progMemInfo.RecordTypeId == recordTypeSettings.get('Program').Record_Type_Id__c)
                accPMIMap.put(progMemInfo.Account__c, prog);
            else if(accPMISpecializationMap.containsKey(progMemInfo.Account__c) && progMemInfo.RecordTypeId == recordTypeSettings.get('Specialization').Record_Type_Id__c)
                accPMISpecializationMap.put(progMemInfo.Account__c, accPMISpecializationMap.get(progMemInfo.Account__c) + '; '+ prog); //specName = specName + prog + '; ';
            else if(!accPMISpecializationMap.containsKey(progMemInfo.Account__c) && progMemInfo.RecordTypeId == recordTypeSettings.get('Specialization').Record_Type_Id__c)
                accPMISpecializationMap.put(progMemInfo.Account__c, prog);
            //Dhruthi Changes End
        }
        system.debug('accPMIMap-->'+accPMIMap);
        system.debug('accPMISpecializationMap-->'+accPMISpecializationMap);
        accountList = [SELECT Id
                        FROM Account
                        WHERE Id in :accountIdList];
        for(Account account : accountList){
            List<String> tempList = new List<String>();
            List<String> tempList1 = new List<String>();
            tempList.addAll(accountIdProgramMembershipMap.get(account.Id));
            // Added - when status is expired PMI field of account should be updated
            Set<String> setOfStringss = new Set<String>(tempList);
            system.debug('hi!');
            if(Trigger.isUpdate) {
            system.debug('hi isupdate');
             for(Program_Membership_Information__c progMemInfo : Trigger.new){
             system.debug('hi inside trigger.new!');
                if(progMemInfo.Member_Status__c != Trigger.oldMap.get(progMemInfo.Id).Member_Status__c && progMemInfo.Member_Status__c == 'Expired') {
                    system.debug('hi inside if new!'+progMemInfo.Member_Status__c);
                    system.debug('hi inside if old!'+Trigger.oldMap.get(progMemInfo.Id).Member_Status__c);
                    for(String s : setOfStringss) {
                        system.debug('hi matches s pp name'+progMemInfo.Partner_Program_Name__c);
                        system.debug('hi matches s '+s);
                        if(s == progMemInfo.Partner_Program_Name__c) {
                        system.debug('hi matches s');
                            setOfStringss.remove(s);
                            tempList1.addAll(setOfStringss);
                        }
                    }
                }
             }
             }
             String programMemInfo ='';
             system.debug('## tempList '+tempList);
             system.debug('## tempList1 '+tempList1);
             if(Trigger.isInsert){
            programMemInfo = String.join(tempList,';');
            system.debug('## programMemInfo insert'+programMemInfo);
            }
            if(Trigger.isUpdate) {
                for(Program_Membership_Information__c progMemInfo : Trigger.new){
                    if(progMemInfo.Member_Status__c != Trigger.oldMap.get(progMemInfo.Id).Member_Status__c && progMemInfo.Member_Status__c == 'Expired') {
                        system.debug('## hi update '+tempList);
                        programMemInfo = String.join(tempList1,';');
                        system.debug('## programMemInfo insert'+programMemInfo);
                    }
                    else {
                        programMemInfo = String.join(tempList,';');
                    system.debug('## programMemInfo insert'+programMemInfo);
                    }
                }
            }
            // ended
            account.Program_Membership_Information__c = programMemInfo;
            account.Partner_Program_Membership__c = accPMIMap.get(account.Id);
            account.Partner_Program_Product_Specialization__c = accPMISpecializationMap.get(account.Id);
        }
        update accountList;
    }
}