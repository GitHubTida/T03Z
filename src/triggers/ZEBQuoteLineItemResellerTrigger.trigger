trigger ZEBQuoteLineItemResellerTrigger on Quote_Line__c (before insert, after update, after insert,before update,before delete) {

    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    
    Set<Id> setQuoteIds = new Set<Id>();
    Set<Id> setQuotelineItmDistri = new Set<Id>();
    list<Quote_Line__c> lstQuoteReseller = new list<Quote_Line__c>(); 
    
    
    if(!Trigger.isDelete){
        for(Quote_Line__c objQuoteLineReseller : trigger.new ){
            setQuoteIds.add(objQuoteLineReseller.PC_Name__c);
            lstQuoteReseller.add(objQuoteLineReseller);
        }
    }
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isBefore){
        Set<id> qids = new Set<ID>();
        Set<id> qliIds = new Set<ID>();
        Map<Id, String> mapQCu = new  Map<Id, String>();
        Map<Id, quoteLineItem> mapQLICu = new  Map<Id, quoteLineItem>();
        //Start APAC-EVM-PC Changes - Used to Get the product
        set<string> familyName = new set<string>();
        set<id> lstProductId = new set<id>();
        map<id,Product2> mapProductObject = new  map<id,Product2> ();
        Map<string,string> mapProductIdProductLine = new Map<string,string>();
        //end APAC-EVM-PC Changes
        for(Quote_Line__c qliRes : trigger.new){
            qids.add(qliRes.Pc_name__C); 
            qliIds.add(qliRes.Quote_Line_Item_Disti__c);
            lstProductId.add(qliRes.Products__c);
        }
        
        //Start APAC-EVM-PC Changes - Used to Get the product
        Map<string,PC_Threshold_Mapping__c> grpThresholdRecs = new Map<string,PC_Threshold_Mapping__c>();
        ZEBTriggerQuoteLineItemHandler.getProductGrouping(lstProductId, mapProductObject,familyName,mapProductIdProductLine );
      //  ZEBTriggerQuoteLineItemHandler.getThresholdValues(familyName,grpThresholdRecs);
        ZEBTriggerQuoteLineItemHandler.getThresholdValues(familyName,grpThresholdRecs);
        Map<string,string> grpShortName = new Map<string,string>();
        ZEBTriggerQuoteLineItemHandler.getLineShortName(grpShortName ,mapProductIdProductLine.values());
        //end APAC-EVM-PC Changes
        
        system.debug(' qids '+qids );
        // APAC EVM PC change  - added one field opportunity.owner_theater__c
        List<Quote> qlist = [Select id,opportunity.owner_theater__c,status,Revision__c from Quote where id in :qids];
        List<QuoteLineItem> qlilist = [Select id, pricebookentryId,discount,Disti_Std_Discount__c from quoteLineItem where id in :qliIds];
        Map<id,Quote> quoteRecs = new Map<id,Quote>();
        for(Quote qiay:qlist ){
            mapQCu.put(qiay.id,qiay.status);
            // APAC EVM PC change 
            quoteRecs.put(qiay.id,qiay);
        }
        system.debug(' mapQCu ' +mapQCu);
        
        for(QuoteLineItem qialiy:qlilist ){
            mapQLICu.put(qialiy.id,qialiy);
        }
        system.debug(' mapQLICu ' +mapQLICu);
        
        for(Quote_Line__c qliRes : trigger.new){
            Decimal listPrice = 0.00; 
            Decimal upliftedCost = 0.00;            
            Decimal stdNetPrice = 0.00;                        
            Decimal maxQuantity = 0.00;
            if(qliRes.List_Price__c !=null)
                listPrice = qliRes.List_Price__c;                       
            if(qliRes.Uplifted_Cost__c !=null )  
                upliftedCost = qliRes.Uplifted_Cost__c; 
            if(qliRes.Standard_Net_Price__c !=null)   
                stdNetPrice = qliRes.Standard_Net_Price__c ;                             
            if(qliRes.Max_Qty__c !=null )   
                maxQuantity = qliRes.Max_Qty__c;
            if(qliRes.Net_Price__c == null )    
                qliRes.Unit_Special_Price__c = listPrice*(1-qliRes.Total_Discount__c/100);  
            else 
            qliRes.Unit_Special_Price__c = qliRes.Net_Price__c;
      
            qliRes.Total_Cost__c = upliftedCost * maxQuantity;
            qliRes.Total_PC_Cost__c= stdNetPrice* maxQuantity;
            qliRes.Total_Net_Price__c = qliRes.Unit_Special_Price__c * maxQuantity; 
            if(mapQLICu.get(qliRes.Quote_Line_Item_Disti__c) != null){
                qliRes.Price_Book_Entry_ID__c = mapQLICu.get(qliRes.Quote_Line_Item_Disti__c).pricebookentryId;
                qliRes.Disti_Standard_Discount__c = mapQLICu.get(qliRes.Quote_Line_Item_Disti__c).Disti_Std_Discount__c;
            }   
            
            // setting the line revision as quote revision
            if(Trigger.IsInsert){
            qliRes.PC_Line_Added_at_Revision__c=quoteRecs.get(qliRes.PC_Name__c).Revision__c;
            }
            //
            //Start APAC-EVM-PC Changes
              //  if(mapQCu.get(qliRes.PC_Name__c)=='Pending' ){
                if(quoteRecs.get(qliRes.PC_Name__c)!=null  && quoteRecs.get(qliRes.PC_Name__c).opportunity.owner_theater__c=='APAC' ){
                if( mapQCu.get(qliRes.PC_Name__c)=='Pending' || mapQCu.get(qliRes.PC_Name__c)=='In Process' ){
                    if(grpThresholdRecs!=null && grpThresholdRecs.get(mapProductObject.get(qliRes.Products__c).ZEB_Product_Family__c)!=null){
                        PC_Threshold_Mapping__c thresholdRec = grpThresholdRecs.get(mapProductObject.get(qliRes.Products__c).ZEB_Product_Family__c);
                        qliRes.PC_PE1__c = thresholdRec.PE1__c!=null?thresholdRec.PE1__c:0;
                        qliRes.PC_PE2__c = thresholdRec.PE2__c!=null?thresholdRec.PE2__c:0;
                    }
                     else{
                        if(grpThresholdRecs!=null && grpShortName!=null && grpShortName.get((qliRes.Product_Line__c))!=null && grpThresholdRecs.get(ZEBTriggerQuoteLineItemHandler.OtherFamily+':'+grpShortName.get(qliRes.Product_Line__c).touppercase())!=null ){
                        
                            PC_Threshold_Mapping__c thresholdRec = grpThresholdRecs.get(ZEBTriggerQuoteLineItemHandler.OtherFamily+':'+grpShortName.get(qliRes.Product_Line__c));
                            qliRes.PC_PE1__c = thresholdRec.PE1__c!=null?thresholdRec.PE1__c:0;
                            qliRes.PC_PE2__c = thresholdRec.PE2__c!=null?thresholdRec.PE2__c:0;
                        }
                        else
                        {
                            PC_Threshold_Mapping__c thresholdRec = grpThresholdRecs.get(ZEBTriggerQuoteLineItemHandler.OtherFamily+':'+ZEBTriggerQuoteLineItemHandler.DefaultRec);
                            qliRes.PC_PE1__c = thresholdRec.PE1__c!=null?thresholdRec.PE1__c:0;
                            qliRes.PC_PE2__c = thresholdRec.PE2__c!=null?thresholdRec.PE2__c:0;
                        }
                    }
                }
                qliRes.PC_Threshold_Identifier__c=ZEBTriggerQuoteLineItemHandler.updateThresholdIndicator(qliRes.PC_PE1__c , qliRes.PC_PE2__c, qliRes.Discount__c);
                }
            //End APAC-EVM-PC Changes
         
        }
        if(Trigger.isUpdate){ 
            lstQuoteReseller = new list<Quote_Line__c>(); 
            for(Quote_Line__c objQuoteLineReseller : trigger.new ){
                if(mapQCu.get(objQuoteLineReseller.PC_Name__c) != null && mapQCu.get(objQuoteLineReseller.PC_Name__c)  != 'Approved')
                    lstQuoteReseller.add(objQuoteLineReseller);
                    
            }
           system.debug('lstQuoteReseller ' +lstQuoteReseller);
            if(lstQuoteReseller.size() > 0)
                ZEBTriggerQuoteLineItemHandler.UpdateQuoteResellerFields(lstQuoteReseller);
        }
    }
    
    if(Trigger.isAfter){         
        system.debug('lstQuoteReseller ' +lstQuoteReseller);    
        if(lstQuoteReseller.size() > 0)
            ZEBTriggerQuoteLineItemHandler.UpdateQuoteObject(lstQuoteReseller);

    }
    if(Trigger.isDelete && Trigger.isBefore){
        Set<Id> setQLIReseller = new Set<Id>();
        //Modified this boolean to change - APAC
        //if(!ZEBUtility.IS_Distributor_Quote_LI_Deleted ){ 
        
            for(Quote_Line__c objQuoteLineItem: trigger.old){  
                setQuoteIds.add(objQuoteLineItem.PC_Name__c);          
            }  
            for(Quote objQuote : [select id,RecordType.name, Status from quote where id in : setQuoteIds]){
                    for(Quote_Line__c objQuoteLineItemReseller: trigger.old){
                        if(objQuote.status == 'Pending' || (objQuote.status == 'In Process' && objQuoteLineItemReseller.Siebel_productid__c == null ) || objQuote.status == 'Rejected'){
                           system.debug('Do nothing');
                        }else{
                             //objQuoteLineItemReseller.addError('Line Item cannot be deleted at this time');// changed as per Anna's request EVM CPQ - 23_12_2015
                             objQuoteLineItemReseller.addError(Label.PC_Restrict_Line_Item_Deletion);
                        }
                        
                       if(objQuoteLineItemReseller.Max_Qty__c <> objQuoteLineItemReseller.Available_Quantity__c  ){
                           objQuoteLineItemReseller.addError(Label.PC_Restrict_Line_Item_Deletion_On_Order);
                        }
                        
                        
                        //if(!ZEBUtility.IS_Distributor_Quote_LI_Deleted && (objQuote.recordtype.name == 'PC NA' ||objQuote.recordtype.name == 'PC NA Approved')){
                        if(!ZEBUtility.IS_Distributor_Quote_LI_Deleted){
                            if(objQuote.Id == objQuoteLineItemReseller.PC_Name__c)
                                setQLIReseller.add(objQuoteLineItemReseller.Quote_Line_Item_Disti__c);        
                        }
                    }  
            }
            system.debug('Nimsi '+setQLIReseller);
            if(setQLIReseller.size() > 0)                         
                ZEBTriggerQuoteLineItemHandler.deleteQuoteLineItemDistributor(setQLIReseller);    
        //}
    }   
    
    }
    
   if(Trigger.isInsert && Trigger.isAfter){
      Set<id> quoteLineIds = new Set<ID>();
      list<Quote> quoteList = new list<Quote>();
     for(Quote_Line__c quoteLinePrice : trigger.new ){
       quoteLineIds.add(quoteLinePrice.Pc_name__c);
       //quoteLineIds.PC_Line_Price_All__c = False;
       
       }
        for(Quote objQuote : [select id,Revision__c from Quote where id in : quoteLineIds] ){
           
           objQuote.PC_PriceAll__c = false;
           quoteList.add(objQuote);
           
        }
        update quoteList;
    } 
}