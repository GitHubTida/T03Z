/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Kushal
    Date        : 19-May-15
    Description : To update total of Assigned and AcceptedLeadstatus in Account Object.
    Revision History
    v0.1    19-May-15    Kushal Soni    To update total of Assigned and AcceptedLeadstatus in Account Object.
    v0.2    26-May-15    Priyanka Singh Added logic for assigning specific number of leads to Partner and Distributor Account
    v0.3    01-Jul-15    Kushal Soni    Added logic to update leads which are already assigned to Partner Account
    v0.4    03-Jul-15    Vishal Jujaray    Included the condition to bypass the validation when the partner account is not modified
***************************************************************/

trigger UpdateLeadsStatusInAccount on Lead (before insert,before update,after delete){
    Map<String,Integer> AccountLeadMap = new Map<String,Integer>();
    List<Account> UpdateAccount=new List<Account>();
    Set<Id> AccountId=new set<Id>();
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Lead'); 
    if(objTriggerDeactivate.IsTriggerActive__c){
        if(Trigger.isInsert || Trigger.isUpdate){
            for(Lead ld: Trigger.new){
                if(ld.status != null && ld.Partner_Company_Name__c != null){
                    AccountId.add(ld.Partner_Company_Name__c);
                    
                    if(trigger.isInsert||(trigger.isupdate && (ld.Partner_Company_Name__c != trigger.oldmap.get(ld.Id).Partner_Company_Name__c))){
                        if(AccountLeadMap.containskey(ld.Partner_Company_Name__c))
                            AccountLeadMap.put(ld.Partner_Company_Name__c+ld.status,AccountLeadMap.get(ld.Partner_Company_Name__c)+1);
                        else
                            AccountLeadMap.put(ld.Partner_Company_Name__c+ld.status,1);
                    }
                }
            }
            system.debug('**AccountLeadMap'+AccountLeadMap);
            system.debug('**AccountId'+AccountId);
        }
     
        if(Trigger.isDelete){
            for(Lead ld: Trigger.old){
                if(ld.status != null && ld.Partner_Company_Name__c != null)
                    AccountId.add(ld.Partner_Company_Name__c);
            }
                system.debug('**DelAccountId'+AccountId);
        }
        
        Map<Id,Account> Actlist = new Map<Id,Account>([select id, accepted_leads__c, assigned_leads__c,Distributor__c from Account where id IN : AccountId]);
        AggregateResult[] ARs = [SELECT count(Id) myCount, Status, Partner_Company_Name__c FROM Lead where Partner_Company_Name__c IN : AccountId GROUP BY Status, Partner_Company_Name__c];
        map<string,integer> countMap = new map<string,integer>();
        
        system.debug('**Actlist'+Actlist);
        system.debug('**ARs'+ARs);
        
        for(AggregateResult ar : ARs){
            countMap.put((string) ar.get('Partner_Company_Name__c')+(string) ar.get('Status'), (integer) ar.get('myCount'));
            system.debug('**countMap'+countMap);
        }
        
        if(Actlist.size() > 0 && Actlist!=null){
            for(Account ac : Actlist.values()){
                ac.assigned_leads__c = String.valueof((countMap.containskey(ac.Id+'Assigned')?countMap.get(ac.Id+'Assigned'):0)+(AccountLeadMap.containskey(ac.Id+'Assigned')?AccountLeadMap.get(ac.Id+'Assigned'):0));
                    
                ac.accepted_leads__c = String.valueof((countMap.containskey(ac.Id+'Accepted')?countMap.get(ac.Id+'Accepted'):0)+(countMap.containskey(ac.Id+'Rejected')?countMap.get(ac.Id+'Rejected'):0)+(countMap.containskey(ac.Id+'Sales Qualified')?countMap.get(ac.Id+'Sales Qualified'):0)+((AccountLeadMap.containskey(ac.Id+'Accepted'))?AccountLeadMap.get(ac.Id+'Accepted'):0)+((AccountLeadMap.containskey(ac.Id+'Rejected'))?AccountLeadMap.get(ac.Id+'Rejected'):0)+((AccountLeadMap.containskey(ac.Id+'Sales Qualified'))?AccountLeadMap.get(ac.Id+'Sales Qualified'):0));
                
                UpdateAccount.add(ac);
                system.debug('**ac.assigned_leads__c'+ac.assigned_leads__c);
                system.debug('**ac.assigned_leads__c'+ac.assigned_leads__c);
            }
            IF(UpdateAccount.size() > 0 && UpdateAccount!=null)
                    Update UpdateAccount;
        }
        if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
            for(lead leadPartner: trigger.new){
                // Added the below column to bypass the existing lead records from displaying the validation  
                if(trigger.isInsert||(trigger.isupdate && (leadPartner.Partner_Company_Name__c != trigger.oldmap.get(leadPartner.Id).Partner_Company_Name__c))){
            
                    if(leadPartner.status != null && leadPartner.Partner_Company_Name__c != null){
                        //system.debug('**final check'+(Integer.valueof(Actlist.get(leadPartner.Partner_Company_Name__c ).assigned_leads__c) !=nu ));
                        //system.debug(leadPartner.Assign_to_Partner_in__c+'***'+ Actlist.get(leadPartner.Partner_Company_Name__c ).distributor__c +'***'+leadPartner.Status+'***'+leadPartner.Partner_Company_Name__c );
                    
                        if(leadPartner.Assign_to_Partner_in__c== 'Siebel' && Actlist.get(leadPartner.Partner_Company_Name__c ).distributor__c == false && leadPartner.Status == 'Assigned'){
                            if(!String.isBlank(Actlist.get(leadPartner.Partner_Company_Name__c ).assigned_leads__c) &&  Integer.valueof(Actlist.get(leadPartner.Partner_Company_Name__c ).assigned_leads__c)  > 6){
                                leadPartner.addError('Can not assign more than 6 leads for Assigned status to a partner');
                            }
                        }
                        if(leadPartner.Assign_to_Partner_in__c== 'Siebel' && Actlist.get(leadPartner.Partner_Company_Name__c ).distributor__c == false && (leadPartner.Status == 'Accepted' || leadPartner.Status == 'Rejected' || leadPartner.Status == 'Sales Qualified')){
                        
                            if(!String.isBlank(Actlist.get(leadPartner.Partner_Company_Name__c ).accepted_leads__c) && Integer.valueof(Actlist.get(leadPartner.Partner_Company_Name__c ).accepted_leads__c) > 6){
                                leadPartner.addError('Can not assign more than 6 leads for Accepted status to a partner');  
                            }
                        }
                        if(leadPartner.Assign_to_Partner_in__c== 'Siebel' && Actlist.get(leadPartner.Partner_Company_Name__c ).distributor__c == true && leadPartner.Status == 'Assigned'){
                            if(!String.isBlank(Actlist.get(leadPartner.Partner_Company_Name__c ).assigned_leads__c) && Integer.valueof(Actlist.get(leadPartner.Partner_Company_Name__c ).assigned_leads__c)  > 15){
                                leadPartner.addError('Can not assign more than 15 leads for Assigned status to a Distributor');
                            }
                        }
                        if(leadPartner.Assign_to_Partner_in__c== 'Siebel' && Actlist.get(leadPartner.Partner_Company_Name__c ).distributor__c == true && (leadPartner.Status == 'Accepted' || leadPartner.Status == 'Rejected' || leadPartner.Status == 'Sales Qualified')){
                            if(!String.isBlank(Actlist.get(leadPartner.Partner_Company_Name__c ).accepted_leads__c) && Integer.valueof(Actlist.get(leadPartner.Partner_Company_Name__c ).accepted_leads__c) > 15){
                                leadPartner.addError('Can not assign more than 15 leads for Accepted status to a Distribtor');
                            }
                        }        
                    }
                }   
            }
        }
    }
}