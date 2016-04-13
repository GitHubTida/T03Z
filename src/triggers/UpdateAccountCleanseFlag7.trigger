/**************************************************************
 Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Rajesh kumar
    Date        : 6/8/2015
    Description : To update the AccountCleanflag as TRUE  in Account Object. 
***************************************************************/
trigger UpdateAccountCleanseFlag7 on DSE__DS_Master_Bean__c (after insert,after update) 
{
    TriggerDeactivateSwitch__c objTriggerDeactivateSwitch = TriggerDeactivateSwitch__c.getValues('Master Bean');
    if (objTriggerDeactivateSwitch.IsTriggerActive__c) {
    
    
    List<Id>AccountId=new List<Id>();
    List<Account> aclist1=new List<Account>();
    List<Account> UpdateAccount=new List<Account>();
    for(DSE__DS_Master_Bean__c mb:Trigger.new)
    {
        If(mb.DSE__DS_Account__c != null && mb.DSE__DS_Custom_Field_19__c!= NULL && mb.DSE__DS_Custom_Field_19__c.equalsIgnoreCase('TRUE'))
        AccountId.add(mb.DSE__DS_Account__c);
    }
aclist1=[Select id,Account_cleansed_flag__c from Account where Id IN : AccountId];
 try
    {
        if(aclist1.size() > 0 && aclist1 != null)
        {
            for(Account ac: aclist1)
            {
             ac.Account_cleansed_flag__c=TRUE;
             UpdateAccount.add(ac);
            }
        }
          if(UpdateAccount.size() > 0 && aclist1 != null)
          Update UpdateAccount;
   }
    catch (Exception e){
       System.debug(e.getMessage());
    }      
 }
 }