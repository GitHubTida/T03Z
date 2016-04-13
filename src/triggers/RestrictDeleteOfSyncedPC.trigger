trigger RestrictDeleteOfSyncedPC on Quote (before delete) {
TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
if(objTriggerDeactivateSwitch.IsTriggerActive__c){
  if(Trigger.isDelete && Trigger.isBefore){
        for(Quote objQuote : Trigger.old){
            if(objQuote.status == 'Pending' || objQuote.status == 'Rejected' || objQuote.Siebel_id__C == null){
               system.debug('Do nothing');
            }else{
                objQuote.addError('Quote cannot be deleted since it is interfaced to Siebel');
            }
        }
    }
    }
}