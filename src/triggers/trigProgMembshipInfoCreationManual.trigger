trigger trigProgMembshipInfoCreationManual on Program_Membership_Information__c (before insert,before update) {
    if(trigger.isinsert && trigger.Isbefore){
        ProgramMemInfoHandler.recordTypeAssignment(trigger.new);
    }
    if(trigger.isinsert && trigger.Isbefore){
        ProgramMemInfoHandler.createProgmemInfo(trigger.new);
    }
}