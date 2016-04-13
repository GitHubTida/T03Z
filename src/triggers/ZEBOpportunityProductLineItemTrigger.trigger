/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : Ragamalika_m@infosys.com
Date        : 31-Mar-15 
Description : This trigger is written to delete fetch the Named Product Family from the Family of product in  
Opportunity LineItem
Ver       Date        Author                Modification 
---       ---------   -----------           -------------------------
V0.1      31-Mar-15   Ragamalika Mohanraj      Initial Code
***************************************************************/
trigger ZEBOpportunityProductLineItemTrigger on OpportunityLineItem (before insert, before delete, after update) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){
        if(trigger.isInsert){
            Map<String,Id> mapNamedProductFamily = new Map<String,Id>();        
            Set<Id> ProdIDList = new Set<Id>();
            Set<Id> oppIdList = new Set<Id>();
            Map<Id,String> ProdMap = new Map<Id,String>();
            Map<Id,Boolean> pMap = new Map<Id,Boolean>();
            Map<Id,ID> poMap = new Map<Id,Id>();
            for (OpportunityLineItem OLI : trigger.new) {
                ProdIDList.add(OLI.Product2Id);
                oppIdList.add(OLI.opportunityid);
            }
            for(Opportunity o:[Select Id, Primary_opportunity__c from Opportunity where id in :oppIdList]){
                poMap.put(o.id, o.Primary_opportunity__c );
            }
            for (Product2 prod : [select Id, Name,Is_Service_Product__c, ZEB_Product_Family__c from product2 where ID IN: ProdIDList]) {
                ProdMap.put(prod.Id,prod.ZEB_Product_Family__c);
                pMap.put(prod.id, prod.Is_Service_Product__c); 
            } 
            for (Named_Product_Family__c n : [select Id, Name from Named_Product_Family__c where name in :ProdMap.values()]) {
                mapNamedProductFamily.put(n.Name,n.Id); 
            }            
            for(OpportunityLineItem oli : Trigger.New){
                if(mapNamedProductFamily.containsKey(ProdMap.get(oli.Product2Id))){
                    oli.Named_Product_Family__c = mapNamedProductFamily.get(ProdMap.get(oli.Product2Id));
                }
                if(pMap.get(oli.Product2id) == true)
                   oli.Is_Service_Product__c = true;
                oli.List_Price__c= 0;    
                oli.Standard_Net_Price__c= 0;    
                if(poMap.get(oli.opportunityid) != null)
                    oli.unitprice= 0; 
            }
        }
        if(trigger.isDelete){
            List<ID> oppIDs = new List<ID>();
            List<ID> NPFIDs = new List<ID>();
            for(OpportunityLineItem opi: Trigger.Old){
                oppIDs.add(opi.OpportunityId);
                NPFIDs.add(opi.Named_Product_Family__c);
            }
            List<Opportunity_Product_Families__c> opf = [Select Id,Named_Product_Family__c from Opportunity_Product_Families__c where Opportunity__c in:oppIDs and Named_Product_Family__c in :NPFIDs ];
            try{
                if(opf.size()>0 && opf!=null)
                    delete opf;
            }
            catch(Exception e){
                System.debug('No Data '+e.getMessage());
            }
        }
        if(trigger.isUpdate || trigger.isInsert){
            Map<Id,String> qliMap = new Map<Id,String>();
            List<ID> qliList = new List<ID>();
            for(OpportunityLineItem oli : Trigger.New){
                if(oli.Quote_Line_Item_ID__c != null){
                    qliMap.put(oli.Quote_Line_Item_ID__c, oli.id);
                    qliList.add(oli.Quote_Line_Item_ID__c);
                }
            }
            if(qliList != null &&  qliList.size() > 0){   
                list<Quote_Line__c> lstQuotelineitem = [select id,Opportunity_Line_Item_ID__c from Quote_Line__c where id in :qliList ];
                if(lstQuotelineitem != null && lstQuotelineitem.size() > 0){
                    for(Quote_Line__c objquotelineitem : lstQuotelineitem ){
                        objquotelineitem.Opportunity_Line_Item_ID__c = qliMap.get(objquotelineitem.id);
                        objquotelineitem.QLIUpdate__c = true;
                    }
                    update lstQuotelineitem;
                }
            }
        }
    }
}