trigger ImportOfflineDocumentTrigger on Task (after insert) {
    
    
    Task[] tasks = Trigger.new;

    ImportOfflineDocumentHelper helper = new ImportOfflineDocumentHelper();
    
    helper.updateAgreementStatus(tasks);

}