trigger ZEBQuoteDoTheUpdate on Quote (before update){
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('PC');
    if(objTriggerDeactivateSwitch.IsTriggerActive__c){
        Set<string> setOppId = new Set<string> ();
        Id rtypeEMEA = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC EMEA').getRecordTypeId();
        Id rtypeEMEAApproved = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC EMEA Approved').getRecordTypeId();
        Id rtypeNA = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC NA').getRecordTypeId();
        Id rtypeNAApproved = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC NA Approved').getRecordTypeId();
        Id rtypeAPAC = Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC APAC').getRecordTypeId();
        ID rtypeAPACApproved= Schema.SObjectType.Quote.getRecordTypeInfosByName().get('PC APAC Approved').getRecordTypeId();        
        User rdd = [select Id from User where Login_ID__c = 'apacrdd' limit 1];
        User gdd = [select Id from User where Login_ID__c = 'apacgdd' limit 1];
        for(Quote objquote : trigger.new){
            setOppId.add(objquote.OpportunityId);       
        }
        List<Opportunity> objOpp = [select Ownerid,owner_theater__C, owner.managerid,Accountid,Account.name,Account.Organization__c, Account.Currencyisocode, Application__c,Pricebook2.Id,Direct_Distributor__c,Direct_End_User__c,Direct_Reseller__c,Distributor__c,End_User__c,End_User_Price__c,Industry__c,Reseller__c,Reseller_Price__c,Opportunity_Distributor__r.Id,Opportunity_Distributor__c, Opportunity_Distributor__r.name, Opportunity_Distributor__r.currencyisocode, Opportunity_End_User__r.Id, Opportunity_End_User__r.name, Opportunity_End_User__r.currencyisocode ,Opportunity_Reseller__r.Id,Opportunity_Reseller__c, Primary_Channel_Partner_AIT__c, Opportunity_Reseller__r.name, Opportunity_Reseller__r.currencyisocode, Vertical__c,Primary_Channel_Partner_AIT__r.Id, Primary_Channel_Partner_AIT__r.name, Primary_Channel_Partner_AIT__r.currencyisocode , Primary_Distributor_AIT__c, Primary_Distributor_AIT__r.Id,Primary_Distributor_AIT__r.name, Primary_Distributor_AIT__r.currencyisocode, Fulfillment_Type__c from Opportunity where id = :setOppId ]; 
        Map<ID, Opportunity> mio = new Map<ID, Opportunity>();
        for(Opportunity obj:objOpp){
            mio.put(obj.id,obj);
        }       
        List<OpportunityShare> oppShareList = new List<OpportunityShare>();  
        for(Quote objQuote:Trigger.new){    
            OpportunityShare oppShare = new OpportunityShare();
            if(mio.get(objquote.OpportunityId).owner_theater__c=='APAC'){
            //giving RDD edit permission 
                oppshare = new OpportunityShare();
                oppShare.UserOrGroupId = rdd.Id;
                oppShare.OpportunityAccessLevel = 'Edit';
                oppShare.OpportunityId = objQuote.opportunityid;
                oppShareList.add(oppShare);
            //giving GDD edit permission
                oppshare = new OpportunityShare();
                oppShare.UserOrGroupId = gdd.Id;
                oppShare.OpportunityAccessLevel = 'Edit';
                oppShare.OpportunityId = objQuote.opportunityid;
                oppShareList.add(oppShare);
                
                String fullFillmentType = mio.get(objQuote.opportunityid).Fulfillment_Type__c;
                //making all flags false initially
                 objQuote.Direct_EndUser__c = false;
                 objQuote.Direct_Distributor__c = false;
                 objQuote.Direct_Reseller__c = false;
                //making flags true based on oppty fulfillment type 
                if(fullFillmentType == 'Direct to End User'  || fullFillmentType =='Distributor Sales In' || fullFillmentType == 'OEM Direct')
                    objQuote.Direct_EndUser__c = true;
                else if(fullFillmentType == 'Distributor Sales Out' || fullFillmentType == 'OEM Sales Out')
                    objQuote.Direct_Distributor__c = true;
                else if(fullFillmentType == 'Direct to Partner')
                    objQuote.Direct_Reseller__c = true;
            
            }else{
                objQuote.Direct_Distributor__c = mio.get(objQuote.opportunityid).Direct_Distributor__c;
                objQuote.Direct_EndUser__c = mio.get(objQuote.opportunityid).Direct_End_User__c;
                objQuote.Direct_Reseller__c = mio.get(objQuote.opportunityid).Direct_Reseller__c;
           }
            if(mio.get(objQuote.opportunityid).Accountid == objQuote.End_User__c && objQuote.Direct_EndUser__c)
                    objQuote.Direct_Account_Currency__c = mio.get(objQuote.opportunityid).Account.Currencyisocode;
            if(mio.get(objQuote.opportunityid).Opportunity_Reseller__c == objQuote.Reseller__c && objQuote.Direct_Reseller__c)
                    objQuote.Direct_Account_Currency__c = mio.get(objQuote.opportunityid).Opportunity_Reseller__r.Currencyisocode;
            if(mio.get(objQuote.opportunityid).Primary_Channel_Partner_AIT__c == objQuote.Reseller__c && objQuote.Direct_Reseller__c)
                    objQuote.Direct_Account_Currency__c = mio.get(objQuote.opportunityid).Primary_Channel_Partner_AIT__r.Currencyisocode;
            if(mio.get(objQuote.opportunityid).Opportunity_Distributor__c == objQuote.Distributor__c && objQuote.Direct_Distributor__c)
                    objQuote.Direct_Account_Currency__c = mio.get(objQuote.opportunityid).Opportunity_Distributor__r.Currencyisocode;
            if(mio.get(objQuote.opportunityid).Primary_Distributor_AIT__c == objQuote.Distributor__c && objQuote.Direct_Distributor__c)
                    objQuote.Direct_Account_Currency__c = mio.get(objQuote.opportunityid).Primary_Distributor_AIT__r.Currencyisocode;
            
            if(mio.get(objQuote.opportunityid).Owner_theater__c == 'EMEA' && 
                (objQuote.Status == 'Approved' || objQuote.Status == 'Expired' || objQuote.Status == 'Cancelled')) 
                    objQuote.RecordTypeId = rtypeEMEAApproved;
            else if(mio.get(objQuote.opportunityid).Owner_theater__c == 'EMEA' && 
                (objQuote.Status != 'Approved' || objQuote.Status != 'Expired' || objQuote.Status != 'Cancelled'  ) )                
                    objQuote.RecordTypeId = rtypeEMEA;
            else if(mio.get(objQuote.opportunityid).Owner_theater__c == 'APAC' && 
                (objQuote.Status == 'Approved' || objQuote.Status == 'Expired' || objQuote.Status == 'Cancelled'))
                    objQuote.RecordTypeId = rtypeAPACApproved;
            else if(mio.get(objQuote.opportunityid).Owner_theater__c == 'APAC' && 
                (objQuote.Status != 'Approved' || objQuote.Status != 'Expired' || objQuote.Status != 'Cancelled'))                
                    objQuote.RecordTypeId = rtypeAPAC;
            else{                
                if(mio.get(objQuote.opportunityid).Owner_theater__c == 'NA' || mio.get(objQuote.opportunityid).Owner_theater__c == 'LATAM'){
                    if(objQuote.Status != 'Approved' || objQuote.Status != 'Expired' || objQuote.Status != 'Cancelled'){                
                        objQuote.RecordTypeId = rtypeNA;
                    }if(objQuote.Status == 'Approved' || objQuote.Status == 'Cancelled' || objQuote.Status == 'Expired'){   
                        objQuote.RecordTypeId = rtypeNAApproved;
                    }
                    if(mio.get(objQuote.opportunityid).Direct_Distributor__c){
                        if(mio.get(objQuote.opportunityid).Opportunity_Distributor__r.name == 'Ingram Micro Data Capture Pos Div.' ||
                           mio.get(objQuote.opportunityid).Primary_Distributor_AIT__r.name == 'Ingram Micro Data Capture Pos Div.'){
                            PC_Approvers__c  PCApproverID = PC_Approvers__c.getValues('JohnId');
                            if(PCApproverID.LoginId__c  != null )
                                objQuote.NAProdMgr__c = PCApproverID.LoginId__c.Trim();
                        }else if(mio.get(objQuote.opportunityid).Opportunity_Distributor__r.name == 'BlueStar Inc' ||
                                mio.get(objQuote.opportunityid).Opportunity_Distributor__r.name == 'Scansource' ||
                                mio.get(objQuote.opportunityid).Opportunity_Distributor__r.name == 'Wynit Distribution, LLC' ||
                                mio.get(objQuote.opportunityid).Primary_Distributor_AIT__r.name == 'BlueStar Inc' ||
                                mio.get(objQuote.opportunityid).Primary_Distributor_AIT__r.name == 'Scansource' ||
                                mio.get(objQuote.opportunityid).Primary_Distributor_AIT__r.name == 'Wynit Distribution, LLC'){
                                PC_Approvers__c  PCApproverID = PC_Approvers__c.getValues('RobertId');
                                if(PCApproverID.LoginId__c  != null )
                                    objQuote.NAProdMgr__c = PCApproverID.LoginId__c.Trim();
                        }
                        if(objQuote.NAProdMgr__c != null){
                            oppShare = new OpportunityShare();
                            oppShare.UserOrGroupId = objQuote.NAProdMgr__c;
                            oppShare.OpportunityAccessLevel = 'Edit';
                            oppShare.OpportunityId = objQuote.opportunityid;
                            oppShareList.add(oppShare);
                        }
                    }
                }
            }
            // Set the Flag for Management Level visibility in the Email template
            if(objQuote.Level1Approved__c && objQuote.L1_User__c == null)
                objQuote.ReadyForL2Approver__c = true;
            else if(objQuote.Level1Approved__c && objQuote.L1Approved__c && objQuote.L1_User__c != null && objQuote.L2_User__c == null )
                objQuote.ReadyForL2Approver__c = true;
            else if(objQuote.Level1Approved__c && objQuote.L2Approved__c && objQuote.L1_User__c != null && objQuote.L2_User__c != null && objQuote.L3_User__c == null)
                objQuote.ReadyForL2Approver__c = true;
            else if(objQuote.Level1Approved__c && objQuote.L3Approved__c && objQuote.L1_User__c != null && objQuote.L2_User__c != null && objQuote.L3_User__c != null && objQuote.L4_User__c == null)
                objQuote.ReadyForL2Approver__c = true;
            else if(objQuote.Level1Approved__c  && objQuote.L4Approved__c && objQuote.L1_User__c != null && objQuote.L2_User__c != null && objQuote.L3_User__c != null && objQuote.L4_User__c != null)
                objQuote.ReadyForL2Approver__c = true;
        }
        system.debug(' oppShareList ' +oppShareList);
        try{ 
            insert oppShareList;
        }catch(Exception e){
           system.debug(e);
        }
    }
}