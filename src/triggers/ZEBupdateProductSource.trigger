trigger ZEBupdateProductSource on OpportunityLineItem (after insert, after update,after delete) {
 TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
        set<string> Source= new Set<String>();
        list<ID> OppID = new list<id>();
        List<opportunity> updateOpp = new List<opportunity>();
        Set<opportunity> updateOppSet = new Set<opportunity>();
        List<opportunity> updateOppFinalList = new List<opportunity>();    
           
        if(trigger.isInsert || trigger.isupdate){
            for(OpportunityLineItem Op : Trigger.new)
          OppID.add(Op.opportunityId);
        }else if(trigger.isdelete){
           for(OpportunityLineItem Op : Trigger.old)
            OppID.add(Op.opportunityId);
        }
        //list<OpportunityLineItem> oppLineItem1 =[select id,Name, Product_Source__c from OpportunityLineItem where OpportunityId in: OppID];
        Map<Id,List<OpportunityLineItem>> oppProductMap = new Map<Id,List<OpportunityLineItem>>();
        for(OpportunityLineItem oppLineItem1 : [select id,Name,OpportunityId,Product_Source__c from OpportunityLineItem where OpportunityId in: OppID]){
            if(oppProductMap.containskey(oppLineItem1.OpportunityId))
                oppProductMap.get(oppLineItem1.OpportunityId ).add(oppLineItem1);
            else
                oppProductMap.put(oppLineItem1.OpportunityId ,new list<OpportunityLineItem>{oppLineItem1});
         }
        for(Id oppor : OppID ){
        if(oppProductMap.containskey(oppor)){
            for(OpportunityLineItem oppLineItem: oppProductMap.get(oppor)){
               Source.add(oppLineItem.Product_Source__c);
            }
            
            if(Source.contains('EVM')){
                if(Source.contains('AIT')){
                    updateOpp.add(new opportunity(id=oppor,Product_Source__c='Both'));
                }else{
                    updateOpp.add(new opportunity(id=oppor,Product_Source__c='EVM'));
                }
            }else if(Source.contains('AIT')){
                updateOpp.add(new opportunity(id=oppor,Product_Source__c='AIT'));
            }else {
                 //do nothing
            }
            Source.clear();
         }
         else{
         updateOpp.add(new opportunity(id=oppor,Product_Source__c=''));
         }
      }
      try{ 
      if(updateOpp.size()>0 && updateOpp!=null){
          updateOppSet.addAll(updateOpp);
          updateOppFinalList.addAll(updateOppSet); 
          update updateOppFinalList;
     }
     }
     Catch(Exception e){
        System.debug('Error Message'+ e.getMessage());
        }
        
      }         
 }