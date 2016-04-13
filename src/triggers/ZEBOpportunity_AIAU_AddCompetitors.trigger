/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : kushal_soni01@infosys.com
Date        : 19-Feb-15 
Description : This trigger is written to insert competitors in a separate related list
Revision History 
Ver       Date        Author           Modification 
---       ---------   -----------      -------------------------
V0.1      19-Feb-15   Kushal Soni      Initial Code
***************************************************************/

trigger ZEBOpportunity_AIAU_AddCompetitors on Opportunity (after insert, after update) {

TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
    
    List<Competitors__c> insertCompetitorsList;
    List<String> competitorValues;
    List<Id> deleteOpp;
    Set<String> oldSetOfCompetitors;
    Set<String> oldSetBackup;
    Set<String> newSetOfCompetitors;
    
    if(Trigger.isInsert){
        insertCompetitorsList=new List<Competitors__c>();
        competitorValues =new List<String>();
        for(Opportunity oppRec:Trigger.new){
            if(oppRec.Competitor__c!=null){
                competitorValues=(oppRec.Competitor__c).split(';');
                System.debug('competitorValues: '+competitorValues);
                for(String compValues:competitorValues)
                {
                    Competitors__c competitorRecord=new Competitors__c();
                    competitorRecord.Opportunity_name__c=oppRec.Id;
                    competitorRecord.Name=compValues;
                    insertCompetitorsList.add(competitorRecord);
                    System.debug('Competitors List'+insertCompetitorsList.size());
                }
            } 
        }
        insert insertCompetitorsList;
    }

    if(Trigger.isUpdate){
        oldSetOfCompetitors=new Set<String>();
        newSetOfCompetitors=new Set<String>();
        oldSetBackup=new Set<String>();
        insertCompetitorsList=new List<Competitors__c>();
        Map<Id, Set<String>> deleteMapCompetitorsAgainstIDs = new Map<Id, Set<String>>();
        Map<Id, Set<String>> insertMapCompetitorsAgainstIDs = new Map<Id, Set<String>>();
        List<Competitors__c> newListToBeInserted = new List<Competitors__c>();
        List<Competitors__c> deleteCompetitors = new List<Competitors__c>();
        
        deleteOpp =new List<Id>();
        Opportunity oldOppRec; 
        for(Opportunity oppRec:Trigger.new){
            // Old Opportunity Record 
            oldOppRec = Trigger.oldMap.get(oppRec.Id);
            system.debug('Old : '+oldOppRec);
            system.debug('New : '+oppRec);
            // Check if Competitor values are present, then add that to the lists and add to old and new maps
            if(oppRec.Competitor__c !=  oldOppRec.Competitor__c){
                if(oldOppRec.Competitor__c !=null)
                    oldSetOfCompetitors.addAll((oldOppRec.Competitor__c).split(';'));
                if(oppRec.Competitor__c !=null)            
                    newSetOfCompetitors.addAll((oppRec.Competitor__c).split(';'));
                system.debug('oldSetOfCompetitors : '+oldSetOfCompetitors);
                system.debug('newSetOfCompetitors : '+newSetOfCompetitors);
                if(oldSetOfCompetitors !=null && oldSetOfCompetitors.size() > 0)
                    oldSetBackup.addAll(oldSetOfCompetitors);
                system.debug('oldSetBackup : '+oldSetBackup);
                // Competitors to be deleted
                oldSetOfCompetitors.removeAll(newSetOfCompetitors);
                // Competitors to be added
                system.debug('oldSetBackup after : '+oldSetBackup);
                if(oldSetBackup !=null && oldSetBackup.size() > 0)
                    newSetOfCompetitors.removeAll(oldSetBackup);
                system.debug('oldSetOfCompetitors after : '+oldSetOfCompetitors);
                system.debug('newSetOfCompetitors after : '+newSetOfCompetitors);
                deleteMapCompetitorsAgainstIDs.put(oldOppRec.id, oldSetOfCompetitors);
                insertMapCompetitorsAgainstIDs.put(oppRec.id, newSetOfCompetitors);                                                                                       
            }
        }
        List<Competitors__c> deleteComp = [Select Id, Name, Opportunity_name__c from Competitors__c where Opportunity_name__c in: deleteMapCompetitorsAgainstIDs.keySet()];
        try{
            if(deleteComp.size()>0 && deleteComp!=null){
                for(Competitors__c comp: deleteComp){
                    if(deleteMapCompetitorsAgainstIDs.get(comp.Opportunity_name__c).contains(comp.Name)){
                        deleteCompetitors.add(comp);
                    }
                }
                delete deleteCompetitors ;
            }
        }
        catch(Exception e)
        {
            System.debug('Deleted List: '+e.getMessage());
        }
        
        for(String oppId: insertMapCompetitorsAgainstIDs.keySet())
        {
            for(String compValue: insertMapCompetitorsAgainstIDs.get(OppId))
            {
                Competitors__c competitorRecord=new Competitors__c();
                competitorRecord.Opportunity_name__c=oppId;
                competitorRecord.Name=compValue;
                insertCompetitorsList.add(competitorRecord);
                System.debug('Competitors List'+insertCompetitorsList.size());
            }                                                                    
        }
        try
        {
            if(insertCompetitorsList.size()>0 && insertCompetitorsList!=null)
                insert insertCompetitorsList;
        }
        catch(Exception e)
        {
            System.debug('Inserted List: '+e.getMessage());
        }   
   }
}}