trigger ZEBUpdateDealOnClosure on Opportunity (after update) {
TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
    List<Id> dealIDList = new List<Id>();
    List<Id> oppIDList = new List<Id>();
    for(Opportunity o : Trigger.new){
        if(o.StageName != null && o.StageName.containsIgnoreCase('Closed'))
            oppIDList.add(o.Id);
    }
    List<Deal_Registration__c> drList = new List<Deal_Registration__c>();
    drList = [SELECT Id FROM Deal_Registration__c WHERE Opportunity__c IN :oppIDList];
    if(drList.size() > 0)
        update drList;
        }
}