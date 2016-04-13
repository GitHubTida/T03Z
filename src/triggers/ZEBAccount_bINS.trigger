trigger ZEBAccount_bINS on Account (before insert, before update) {
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Account');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c){
        if (Trigger.isInsert){
          for (Account tempAcc : Trigger.new) {
                if (ZEBUtility.isNotZebraInterfaceUser()) {
                    if (tempAcc.BillingCity == null)
                        tempAcc.addError('Please enter the city');
                    if (tempAcc.BillingStreet == null)
                           tempAcc.addError('Please enter the street');
                    if (tempAcc.BillingCountry == 'United States' && tempAcc.BillingStatecode == null)
                           tempAcc.addError('If Country is United States, then Billing State is required.');
                }
                tempAcc.Translated_Name__c = tempAcc.Name;
            }
        }
        if (Trigger.isUpdate){
            for (Account tempAcc : Trigger.new) {
                if (ZEBUtility.isNotZebraInterfaceUser() && !ZEBUtility.inFutureCalloutContext) {
                    if (tempAcc.BillingCity == null)
                        tempAcc.addError('Please enter the city');
                   if (tempAcc.BillingStreet == null)
                       tempAcc.addError('Please enter the street');
                }
            }
        }
    }
}