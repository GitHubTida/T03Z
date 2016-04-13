/**************************************************************
    Copyright © 2015 Zebra Technologies. All rights reserved.
    Author      : Nikhil Kumar
    Date        : 20-Aug-15
    Revision History
    Ver       Date        Author            Modification
    ---       ---------   -----------       -------------------------
    V0.1      20-Aug-15   Nikhil Kumar         Initial Code  
 ***************************************************************/
trigger DD_UpdateStatusCheckOrder on DD_Demo__c (Before insert, After insert,Before update,After update,After delete) {
 public boolean postalcode{get;set;}
  
 if(TriggerDeactivateSwitch__c.getAll().Containskey('Demo Request') && 
            TriggerDeactivateSwitch__c.getAll().get('Demo Request').IsTriggerActive__c){
    
  
    DD_GeneralUtility utility = new  DD_GeneralUtility();
    
    if(Trigger.isbefore && Trigger.IsInsert){  
    
         //Set of Account Manager
        Set<id> AccountMangerList = New set<id>();
        
       DD_Demo__c demo = Trigger.new[0];
        
       AccountMangerList.Add(demo.Account_Manager__c);    
        
       Boolean outstanding_error = utility.CheckOutstandingLimit(AccountMangerList);
        
        
       if(outstanding_error){
           if(DD_GeneralUtility.RecCountOver.get(UserInfo.getUserId())==null )
            {
           
             demo.adderror('Sorry, You cannot create new demo requests as you have reached outstanding limit, (# of Demo Requests: '+DD_GeneralUtility.RecCountOpen.get(UserInfo.getUserId())+' Open and 0 Overdue record(s)).');                               
            }else
            {
           demo.adderror('Sorry, You cannot create new demo requests as you have reached outstanding limit, (# of Demo Requests: '+DD_GeneralUtility.RecCountOpen.get(UserInfo.getUserId())+' Open and '+DD_GeneralUtility.RecCountOver.get(UserInfo.getUserId())+' Overdue record(s)).');
                                 
            }
           
        }
    
    }
    
    //update Theater field on demo request
    if(Trigger.isbefore && (Trigger.Isupdate || trigger.isInsert)) {
   
        //Set of Account Manager id
        Set<id> AccMrgId = New Set<id>();
        
        For(DD_Demo__c tempdemo : trigger.New){
            
            If(tempdemo.Account_Manager__c!=Null){
                AccMrgId.Add(tempdemo.Account_Manager__c);
            }
            
        }
        
        If(AccMrgId.size()>0){
            
            Map<id,user> AccMgrMap = New Map<id,user>([Select id,Theater__c from User Where Id IN : AccMrgId]);
            
            For(DD_Demo__c tempdemo : trigger.New){
                if(AccMgrMap.containskey(tempdemo.Account_Manager__c))
                tempdemo.Theater_for_Sharing__c =AccMgrMap.get(tempdemo.Account_Manager__c).Theater__c;
            }
            
        }
    
    }
   if(Trigger.isbefore && Trigger.Isupdate)
    {
        set<string> statusstr = New Set<String>();
        statusstr.Add('Closed With Missing Product');
        statusstr.Add('Closed');
        
        
        //Set of country for mapping
        Set<string> ConMap = New Set<String>();
        
        
        For(DD_Demo__c  demo : Trigger.New){
            
            System.debug('===Shippeddate==='+demo.Shipped_Date__c+Trigger.oldMap.get(demo.id).Shipped_Date__c);
            If(demo.Shipped_Date__c!=Trigger.oldMap.get(demo.id).Shipped_Date__c){
                System.debug('wefke');
                demo.Demo_Status__c='Shipped';
            }
            
            //for printing retrun address
            if(demo.Demo_Status__c!=null && !statusstr.contains(demo.Demo_Status__c) && /* demo.Demo_Status__c!=trigger.oldMap.get(demo.id).Demo_Status__c && */demo.Theater__c!='EMEA'){
                 
                 demo.Address_Line1__c=demo.Street_demopool__c;
                 System.debug('Address Line 1'+demo.Address_Line1__c);
                 demo.Address_Line_2__c=demo.City_demopool__c;
                 demo.Address_Line_3__c=demo.StateProvince_demopool__c;
                 demo.Address_Line_4__c=demo.country_demopool__c;
                  postalcode=true;
                 demo.Address_Line_5__c=demo.Post_Code_ZIP_demopool__c;
            }else if(demo.Demo_Status__c!=null && !statusstr.contains(demo.Demo_Status__c) /*&&  demo.Demo_Status__c!=trigger.oldMap.get(demo.id).Demo_Status__c */){
                
                ConMap.Add(demo.Country__c);
            
            }
        
        } 
        
        //Map of Country Name vs Country
        Map<string,DD_Address__c> MApCountry = New Map<string,DD_Address__c>();
        
        if(ConMap.size()>0){
            For(DD_Address__c Addres:[select id,Address__c,Address_Line_1__c,Address_Line_2__c,Address_Line_3__c,Address_Line_4__c,Street__c,City__c ,State__r.Name ,Country_Lookup__r.Name,Post_Code_ZIP__c from DD_Address__c where Country_Lookup__r.Name IN:ConMap and recordtype.name='Returned Address']){
            
                MApCountry.put(Addres.Country_Lookup__r.Name,Addres);
            }
        }    
        //check if the Approval comment added on Rejection
        Map<Id, DD_Demo__c> demoMap = 
                                  new Map<Id, DD_demo__c>{};

        for(DD_Demo__c demorequest: trigger.new)
        {
            // Put all objects for update that require a comment check in a map,
                 
            if (demorequest.Approval_Status__c == 'Rejected')
            { 
              demoMap.put(demorequest.Id, demorequest);
             
            }
             if(ConMap.size()>0){
              
                 If(MApCountry.containskey(demorequest.Country__c)){
                 postalcode=false;
                 demorequest.Address_Line1__c=MApCountry.get(demorequest.Country__c).Address_Line_1__c;
                 System.debug('Address Line 1'+demorequest.Address_Line1__c);
                   demorequest.Address_Line_2__c=MApCountry.get(demorequest.Country__c).Address_Line_2__c;
                   System.debug('Address Line 2'+ demorequest.Address_Line_2__c);
                    demorequest.Address_Line_3__c=MApCountry.get(demorequest.Country__c).Address_Line_3__c;
                     System.debug('Address Line 3'+ demorequest.Address_Line_3__c);
                  demorequest.Address_Line_4__c=MApCountry.get(demorequest.Country__c).Address_Line_4__c;
                  System.debug('Address Line 4'+ demorequest.Address_Line_4__c);
                 }                               
             
             }
            
          }         
          
          utility.checkRejectionComment(demoMap);  
              
              
  }
  
  if(Trigger.IsAfter && (Trigger.IsDelete || Trigger.isInsert)){
  
    //Set of Account Manager
    Set<id> AccMgr = New set<id>();
    
    For(DD_Demo__c demo : (Trigger.isInsert ? Trigger.new : Trigger.old))
    {
         AccMgr.Add(demo.Account_Manager__c); 
    }
    
    DD_GeneralUtility CheckOutstanding = new DD_GeneralUtility();
    CheckOutstanding.CheckOutstandingLimit(AccMgr);
            
 }        
  //Sharing rule
  If(Trigger.IsAfter && (Trigger.isInsert || Trigger.IsUpdate)){
        
        
        
        if(trigger.isInsert || trigger.IsUpdate) {
        
            //Set of demo id
            Set<id> Demoid = New Set<id>();
            for(DD_Demo__c demotemp : trigger.new){
            
                Demoid.Add(demotemp.id);
            } 
        
            Set<String> SharedUserid = New Set<String>();
            
            For( DD_Demo__Share TempShare :[Select id,UserOrGroupId,UserOrGroup.Name,AccessLevel,RowCause,ParentId  from DD_Demo__Share Where ParentId IN: Demoid and RowCause='Demo_Access__c' ]){
                
                SharedUserid.Add(String.ValueOf(TempShare.ParentId)+String.Valueof(TempShare.UserOrGroupId));
            
            }
            
            
            List<DD_Demo__Share> lst_DemoShare = new List<DD_Demo__Share>();
            for(DD_Demo__c demo : trigger.new){
            
                If(demo.Ownerid != demo.Account_Manager__c){
                
                    If(demo.Account_Manager__c!=Null && !SharedUserid.Contains(String.ValueOf(demo.id)+String.ValueOf(demo.Account_Manager__c))){
                        DD_Demo__Share AMshare = new DD_Demo__Share();
                        AMshare.ParentId = demo.Id;
                        AMshare.UserOrGroupId = demo.Account_Manager__c;
                        AMshare.AccessLevel = 'edit';
                        AMshare.RowCause = Schema.DD_Demo__Share.RowCause.Demo_Access__c;
                        lst_DemoShare.add(AMshare);
                   } 
                }
                
                If(demo.System_Engineer__c!=Null && !SharedUserid.Contains(String.ValueOf(demo.id)+String.ValueOf(demo.System_Engineer__c))){
                
                    DD_Demo__Share SEshare = new DD_Demo__Share();
                    SEshare.ParentId = demo.Id;
                    SEshare.UserOrGroupId = demo.System_Engineer__c;
                    SEshare.AccessLevel = 'edit';
                    SEshare.RowCause = Schema.DD_Demo__Share.RowCause.Demo_Access__c;
                    lst_DemoShare.add(SEshare);
                }
                
                If(demo.Manager__c!=Null && !SharedUserid.Contains(String.Valueof(demo.id)+String.ValueOf(demo.Manager__c))){
                
                    DD_Demo__Share ManagerShare = new DD_Demo__Share();
                    ManagerShare.ParentId = demo.Id;
                    ManagerShare.UserOrGroupId = demo.Manager__c;
                    ManagerShare.AccessLevel = 'edit';
                    ManagerShare.RowCause = Schema.DD_Demo__Share.RowCause.Demo_Access__c;
                    lst_DemoShare.add(ManagerShare);
                }
                If(demo.DD_Program_Admin__c!=Null && !SharedUserid.Contains(String.Valueof(demo.id)+String.Valueof(demo.DD_Program_Admin__c))){
                
                    DD_Demo__Share AdminShare = new DD_Demo__Share();
                    AdminShare.ParentId = demo.Id;
                    AdminShare.UserOrGroupId = demo.DD_Program_Admin__c;
                    AdminShare.AccessLevel = 'edit';
                    AdminShare.RowCause = Schema.DD_Demo__Share.RowCause.Demo_Access__c;
                    lst_DemoShare.add(AdminShare);
               }     
            }
            If(lst_DemoShare.Size()>0)
            Database.SaveResult[] demoShareInsertResult = Database.insert(lst_DemoShare,false);
            
            }
  }  
    if(Trigger.IsAfter && Trigger.isupdate)
    {
             
          
              
        //ids of demo request
        set<id> Demoid= New set<id>();
        
        Set<id> userId = new Set<id>();
        
        For(DD_Demo__c  demo : Trigger.New){
            System.debug('===DemoStatus==='+demo.Demo_Status__c+Trigger.oldMap.get(demo.id).Demo_Status__c);
            if(demo.Demo_Status__c!=Null && demo.Demo_Status__c=='Shipped' &&demo.Demo_Status__c!=Trigger.oldmap.get(demo.id).Demo_Status__c && 
                                                ReserveProduct__c.getAll().containskey(demo.Demo_Status__c)){
                Demoid.Add(demo.id);    
            }
            if((demo.Demo_status__c !=Trigger.oldmap.get(demo.id).Demo_Status__c) && 
                                (demo.Demo_status__c == 'Closed' || demo.Demo_status__c == 'Closed With Missing Product' )){
                 userId.add(demo.Account_Manager__c);                
            }
        }
        
        if(userId.size() > 0){
         List<User> updateUserList = new List<User>();
         List<User> userList = [select id,Access_status__c from User where id IN :userId];
         for(User usr : userList){
             If(usr.access_status__c!='Active'){
                 usr.access_status__c = 'Active';
                 updateUserList.add(usr);
             }     
         }
         
         If(updateUserList.Size()>0)
             update updateUserList; 
         }  
        
        If(Demoid.size()>0){
        
            
            //List to update
            List<DD_Reserved_Product__c> ToUpdate = New List<DD_Reserved_Product__c>();
            
            For(DD_Reserved_Product__c tempRes : [select id,Product_Status__c,Demo_Request__r.Demo_Status__c from DD_Reserved_Product__c Where Demo_Request__c IN: Demoid]){
                //if(tempRes.Product_Status__c != TempRes.Demo_Request__r.Demo_Status__c){
                  if(ReserveProduct__c.getAll().containskey(tempRes.Demo_Request__r.Demo_Status__c)){  
                    //tempRes.Product_Status__c= TempRes.Demo_Request__r.Demo_Status__c;
                    tempRes.Product_Status__c=ReserveProduct__c.getall().get(tempRes.Demo_Request__r.Demo_Status__c).Product_Status__c;
                    ToUpdate.Add(tempRes );
                    System.debug('------PRDstatus---'+tempRes.Product_Status__c);
                }    
            }
            
            If(ToUpdate.Size()>0)
            Update ToUpdate;
        }
     } 
     
    
   
   }  
   
 }