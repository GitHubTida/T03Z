/**************************************************************
Copyright © 2015 Zebra Technologies. All rights reserved.
Author      : 
Date        : 20-Aug-2015
Description :  

--------------------------------------------------------------------------------
MODIFICATION HISTORY
 
MODIFICATION DATE   MODIFIED BY             REASON
20-Aug-2015         Navya Ashok             initial code
-------------------------------------------------------------------------------- 
***************************************************************/
trigger DD_DuplicateDemoPoolRegions on
 DD_Demo_Pool__c(before insert,before update) {
 List<String> region= new List<String>();
 List<String> demoPoolval= new List<String>();
 
   //for(integer i=0; i<trigger.new.size(); i++){
   for(DD_Demo_Pool__c demoPool : trigger.new) {
             
             region.add(demoPool.Region__c);
              demoPoolval.add(demoPool.Name);
              
    }
        
    List<DD_Demo_Pool__c> demoPoolList=  [SELECT Id, name,Region__c
                                                             FROM DD_Demo_Pool__c
                                                              WHERE Region__c IN: region And
                                                               name IN: demoPoolval ];
    
    set<string> setDemo = new set<string>();
    if(demoPoolList.size()>0){
        for(DD_Demo_Pool__c demo : demoPoolList){
            setDemo.add(demo.Name+demo.Region__c);
        }
    }
    if(setDemo!=null && setDemo.size()>0){
    for(DD_Demo_Pool__c demoPool : trigger.new){
        if(trigger.isinsert){
            if(setDemo.contains(demoPool.Name+demoPool.Region__c)){
                demoPool.addError('Demo Pool  \''  + 
                        demoPool.name+'\' already exists for '+ demoPool.Region__c);
            }
        }
        if(trigger.isupdate){
            if((trigger.newMap.get(demoPool.id).Name!=trigger.oldMap.get(demoPool.id).Name)|| (trigger.newMap.get(demoPool.id).Region__c!=trigger.oldMap.get(demoPool.id).Region__c) ){
                if(setDemo.contains(demoPool.Name+demoPool.Region__c) ){
                  
                    demoPool.addError('Demo Pool  \''  + 
                            demoPool.name+'\' already exists for \''+ demoPool.Region__c);
                }
            }
        }
                                                               
    }   
    }
    /*if (demoPoolList.size() > 0 ) {
        for (DD_Demo_Pool__c demoPool: Trigger.new){
           for(DD_Demo_Pool__c existingRecords: demoPoolList){
           
            if(Trigger.isUpdate){
                  System.debug('Trigger.oldMap.get(demoPool.ID).name' +Trigger.oldMap.get(demoPool.ID).name);
                  System.debug('demoPool.name' +demoPool.name);
                  System.debug('Trigger.oldMap.get(demoPool.Id).Region__c' +Trigger.oldMap.get(demoPool.Id).Region__c);
                  System.debug('demoPool.Region__c ' +demoPool.Region__c);
                  System.debug('existingRecords.name' +existingRecords.name);
                  System.debug('demoPool.name' +demoPool.name);
                  System.debug('existingRecords.Region__c' +existingRecords.Region__c);
                  System.debug('demoPool.Region__c' +demoPool.Region__c);
                   if((Trigger.oldMap.get(demoPool.ID).name != demoPool.name ||
                           Trigger.oldMap.get(demoPool.Id).Region__c != demoPool.Region__c ) &&
                           (existingRecords.name== demoPool.name) && 
               (existingRecords.Region__c == demoPool.Region__c )){
               
                    demoPool.addError('Demo Pool \''  + 
                    demoPoolList[0].name+'\' already exists for '+ demoPoolList[0].Region__c);
    
               }
               }
            else if(Trigger.isInsert) {  
       
           if((existingRecords.name== demoPool.name) && 
               (existingRecords.Region__c== demoPool.Region__c) ) {
               
                    demoPool.addError('Demo Pool\''  + 
                    demoPoolList[0].name+'\' already exists for '+ demoPoolList[0].Region__c);
    
                }
            }
          }
        
        }
        
    }*/
    
    
    }