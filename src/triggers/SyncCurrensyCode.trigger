trigger SyncCurrensyCode on SR_DR__c (before insert, before update) {
TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
    set<id> oppids = new set<id>();
    for(SR_DR__c CPRRec:Trigger.new){
        oppids.add(CPRRec.Opportunity__c);
    }
    
    Map<id,Opportunity> oppRecords= new Map<id,Opportunity>([select id, CurrencyIsoCode from Opportunity where id in :oppids]);
    for(SR_DR__c CPRRec:Trigger.new){
        if(Trigger.isbefore && (Trigger.isinsert ||Trigger.isupdate)){
            if(CPRRec!=null && oppRecords.get(CPRRec.Opportunity__c)!=null){
                CPRRec.CurrencyIsoCode  = oppRecords.get(CPRRec.Opportunity__c).CurrencyIsoCode ;
            }
        }
    }
   }
}