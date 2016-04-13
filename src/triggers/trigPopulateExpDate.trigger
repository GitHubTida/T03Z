trigger trigPopulateExpDate on Contact_Certification__c (before insert,before update,after insert,after update) {

if(trigger.isinsert && trigger.Isbefore){
    ContactCertificationHandler.PopExpDate(trigger.new);
}

if(trigger.isupdate && trigger.Isbefore){
    ContactCertificationHandler.PopExpDatebySys(trigger.new);
}


}