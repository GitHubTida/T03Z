/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : kushal_soni01@infosys.com
Date        : 18-Feb-15 
Description : This trigger is written to show Win Loss Reason of a Opportunity in a separate related list
Revision History 
Ver       Date        Author           Modification 
---       ---------   -----------      -------------------------
V0.1      18-Feb-15   Kushal Soni      Initial Code
***************************************************************/
trigger ZEBOpportunity_AIAU_AddWinLossReason on Opportunity (after insert, after update) 
{

  TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c ){
    
  List<WinLoss_Reason__c> insertWinLossList;
  List<String> setForClosureReason;
  List<Id> deleteOpp;
  if(Trigger.isInsert)
  {
   insertWinLossList=new List<WinLoss_Reason__c>();
   setForClosureReason =new List<String>();
  
        for(Opportunity oppRec:Trigger.new)
        {
            if(oppRec.Reason_for_Win_Loss__c!=null)
             {
                             setForClosureReason=(oppRec.Reason_for_Win_Loss__c).split(';');
                             System.debug('setForClosurRreason'+setForClosureReason);
                             //Creating Win loss reason records and adding to list////
                              for(String closureReason:setForClosureReason)
                              {
                                    WinLoss_Reason__c winLossRec=new WinLoss_Reason__c();
                                    winLossRec.Opportunity__c=oppRec.Id;
                                    winLossRec.Win_Loss_Reason_value__c=closureReason;
                                    winLossRec.Name=closureReason;
                                    insertWinLossList.add(winLossRec);
                                    System.debug('WinLoss List'+insertWinLossList.size());
                              }
            } 
       }
       try
       {
         insert insertWinLossList;
       }
       catch(Exception e)
       {
       System.debug('Win Loss List'+e.getMessage());
       }
  }
  
   if(Trigger.isUpdate)
   {
     setForClosureReason=new List<String>();
     insertWinLossList=new List<WinLoss_Reason__c>();
     deleteOpp =new List<Id>();         
               for(Opportunity oppRec:Trigger.new)
               {
                   if(oppRec.Reason_for_Win_Loss__c!=null)
                   {
                     deleteOpp.add(oppRec.Id);
                     setForClosureReason=(oppRec.Reason_for_Win_Loss__c).split(';');
                     System.debug('setForClosureReason'+setForClosureReason);
                     
                     for(String closureReason:setForClosureReason)
                     {
                                WinLoss_Reason__c winLossRec=new WinLoss_Reason__c();
                                winLossRec.Opportunity__c=oppRec.Id;
                                winLossRec.Win_Loss_Reason_value__c=closureReason;
                                winLossRec.Name=closureReason;
                                insertWinLossList.add(winLossRec);
                                System.debug('WinLoss List'+insertWinLossList.size());
                     }         
                   }
               }         
              
              List<WinLoss_Reason__c> deleteWinLoss=[select id,Opportunity__c  from WinLoss_Reason__c where Opportunity__c in :deleteOpp];
                //Deleteing records//
                try
                {
                delete deleteWinLoss;
                }
                catch(Exception e)
                {
                 System.debug('Deleted records'+e.getMessage());
                }
   try
   {
     insert insertWinLossList;
   }
   catch(Exception e)
   {
   System.debug('Win Loss List'+e.getMessage());
   }
  }
  }
}