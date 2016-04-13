trigger partner_contact_de_dup on DSE__DS_DuplicateBean__c (before insert,before update) 
{
for(DSE__DS_DuplicateBean__c Ds: Trigger.new)
{
  
  
  
  if( (ds.Account_Id_of_Master__c==ds.Account_Id_of_Duplicate__c)
     && (ds.DSE__DS_Source_Master__c=='Contact'&& ds.DSE__DS_Source_Duplicate__c =='Contact')
     && (ds.Email_of_Master__c==ds.Email_of_Duplicate__c))
{    

 //Block 1 Master is contact and duplicate is Siebel
  if( (ds.EVM_Contact_ID_of_Master__c== null || ds.EVM_Contact_ID_of_Master__c==''  )
  && 
  (ds.AIT_Contact_ID_of_Master__c == null || ds.AIT_Contact_ID_of_Master__c =='')
  && 
  (ds.AIT_Contact_ID_of_Duplicate__c!=null && ds.AIT_Contact_ID_of_Duplicate__c !='' )
  && 
  (ds.EVM_Contact_ID_of_Duplicate__c == ''|| ds.EVM_Contact_ID_of_Duplicate__c == null))
    {
      
      ds.DSE__DS_Toggle_Master__c=TRUE;
      ds.DSE__DS_No_Duplicate__c=FALSE;
      ds.Manual_Merge_Required__c=FALSE;
      ds.Auto_Merged__c=TRUE;
          }
    //Block 2  Master is contact and duplicate is enterprise
    
    else if ( (ds.EVM_Contact_ID_of_Master__c== null || ds.EVM_Contact_ID_of_Master__c=='')
    && 
    (ds.AIT_Contact_ID_of_Master__c == null  || ds.AIT_Contact_ID_of_Master__c =='')
    && 
    (ds.AIT_Contact_ID_of_Duplicate__c==null || ds.AIT_Contact_ID_of_Duplicate__c =='' )
    && 
    (ds.EVM_Contact_ID_of_Duplicate__c != ''&& ds.EVM_Contact_ID_of_Duplicate__c != null))
    {
   
      ds.DSE__DS_Toggle_Master__c=TRUE;
      ds.DSE__DS_No_Duplicate__c=FALSE;
      ds.Manual_Merge_Required__c=FALSE;
      ds.Auto_Merged__c=TRUE;
    
    }
    
    //Block3 Master is Enterprise and duplicate is Siebel
    
      else if ((ds.EVM_Contact_ID_of_Master__c!= null && ds.EVM_Contact_ID_of_Master__c!='')
      && 
      (ds.AIT_Contact_ID_of_Master__c == null || ds.AIT_Contact_ID_of_Master__c =='')
      && 
      (ds.AIT_Contact_ID_of_Duplicate__c!=null && ds.AIT_Contact_ID_of_Duplicate__c !='' )
      && 
      (ds.EVM_Contact_ID_of_Duplicate__c == ''|| ds.EVM_Contact_ID_of_Duplicate__c == null))
   {
 
     ds.DSE__DS_Toggle_Master__c=TRUE;
     ds.DSE__DS_No_Duplicate__c=FALSE;
     ds.Manual_Merge_Required__c=FALSE;
      ds.Auto_Merged__c=TRUE;
     
   }
   
   //Block4 Master is Enterprise and duplicate is Contact
   
   else if ((ds.EVM_Contact_ID_of_Master__c!= null && ds.EVM_Contact_ID_of_Master__c!='')
   && 
 (  ds.AIT_Contact_ID_of_Master__c == null || ds.AIT_Contact_ID_of_Master__c =='')
   && 
  ( ds.AIT_Contact_ID_of_Duplicate__c==null || ds.AIT_Contact_ID_of_Duplicate__c =='' )
   && 
  ( ds.EVM_Contact_ID_of_Duplicate__c == ''|| ds.EVM_Contact_ID_of_Duplicate__c == null))
   {
  
       ds.DSE__DS_Toggle_Master__c=FALSE;
       ds.DSE__DS_No_Duplicate__c=FALSE;
       ds.Manual_Merge_Required__c=FALSE;
      ds.Auto_Merged__c=TRUE;
     
   }

   //Block5 Master is Siebel and duplicate is  contact
   
  else if ((ds.EVM_Contact_ID_of_Master__c== null || ds.EVM_Contact_ID_of_Master__c=='')
  && 
  (ds.AIT_Contact_ID_of_Master__c != null && ds.AIT_Contact_ID_of_Master__c !='')
  && 
  (ds.AIT_Contact_ID_of_Duplicate__c==null || ds.AIT_Contact_ID_of_Duplicate__c =='') 
  && 
  (ds.EVM_Contact_ID_of_Duplicate__c == ''||ds.EVM_Contact_ID_of_Duplicate__c == null))
  { 
  
     ds.DSE__DS_Toggle_Master__c=FALSE;
     ds.DSE__DS_No_Duplicate__c=FALSE;
     ds.Manual_Merge_Required__c=FALSE;
     ds.Auto_Merged__c=TRUE;
    
  } 
  
  //Block6 Master is Siebel and duplicate is enterprise
  
  else if ((ds.EVM_Contact_ID_of_Master__c== null || ds.EVM_Contact_ID_of_Master__c=='')
  && 
  (ds.AIT_Contact_ID_of_Master__c != null && ds.AIT_Contact_ID_of_Master__c !='')
  && 
  (ds.AIT_Contact_ID_of_Duplicate__c==null || ds.AIT_Contact_ID_of_Duplicate__c =='') 
  && 
  (ds.EVM_Contact_ID_of_Duplicate__c != ''&& ds.EVM_Contact_ID_of_Duplicate__c != null))
  { 
   
     ds.DSE__DS_Toggle_Master__c=FALSE;
     ds.DSE__DS_No_Duplicate__c=FALSE;
     ds.Manual_Merge_Required__c=FALSE;
     ds.Auto_Merged__c=TRUE;
    
  }
  
  //Block7 Master is Siebel and duplicate is Siebel
  
   else if ((ds.EVM_Contact_ID_of_Master__c== null || ds.EVM_Contact_ID_of_Master__c=='')
   && 
   (ds.AIT_Contact_ID_of_Master__c != null && ds.AIT_Contact_ID_of_Master__c !='')
   && 
   (ds.AIT_Contact_ID_of_Duplicate__c!=null && ds.AIT_Contact_ID_of_Duplicate__c !='') 
   && 
   (ds.EVM_Contact_ID_of_Duplicate__c ==''|| ds.EVM_Contact_ID_of_Duplicate__c == null))
  {
   
     ds.DSE__DS_No_Duplicate__c=True;
     ds.DSE__DS_Toggle_Master__c=FALSE;
     ds.Manual_Merge_Required__c=True;
     ds.Auto_Merged__c=FALSE;
   
  }
  
 // Block 8 Master is Enterprise  and duplicate is Enterprise 
   
   else if ((ds.EVM_Contact_ID_of_Master__c!= null && ds.EVM_Contact_ID_of_Master__c!='')
   && 
   (ds.AIT_Contact_ID_of_Master__c == null || ds.AIT_Contact_ID_of_Master__c =='')
   && 
   (ds.AIT_Contact_ID_of_Duplicate__c==null || ds.AIT_Contact_ID_of_Duplicate__c =='') 
   && 
   (ds.EVM_Contact_ID_of_Duplicate__c !=''&& ds.EVM_Contact_ID_of_Duplicate__c != null))
  {
     
     ds.DSE__DS_No_Duplicate__c=True;
     ds.DSE__DS_Toggle_Master__c=FALSE;
     ds.Manual_Merge_Required__c=True;
     ds.Auto_Merged__c=FALSE;
    
  }

// Block 9 Master is Zebra Contact  and duplicate is Zebra Contact 
   
   else if ((ds.EVM_Contact_ID_of_Master__c== null || ds.EVM_Contact_ID_of_Master__c=='')
   && 
   (ds.AIT_Contact_ID_of_Master__c == null || ds.AIT_Contact_ID_of_Master__c =='')
   && 
   (ds.AIT_Contact_ID_of_Duplicate__c==null || ds.AIT_Contact_ID_of_Duplicate__c =='') 
   && 
   (ds.EVM_Contact_ID_of_Duplicate__c ==''|| ds.EVM_Contact_ID_of_Duplicate__c == null))
  {
     If(ds.Master_Contact_Last_Modified_Date__c > ds.Duplicate_contact_Last_modified_Date__c)
     
     {
      
        
         ds.DSE__DS_Toggle_Master__c=FALSE;
         ds.DSE__DS_No_Duplicate__c=FALSE;
         ds.Manual_Merge_Required__c=FALSE;
         ds.Auto_Merged__c=TRUE;
        
     }
     
     else if(ds.Master_Contact_Last_Modified_Date__c < ds.Duplicate_contact_Last_modified_Date__c)
     {
        
         ds.DSE__DS_Toggle_Master__c=True;
         ds.DSE__DS_No_Duplicate__c=FALSE;
         ds.Manual_Merge_Required__c=FALSE;
         ds.Auto_Merged__c=True;
       
     }
      else if(ds.Master_Contact_Last_Modified_Date__c == ds.Duplicate_contact_Last_modified_Date__c)
     {
       
         ds.DSE__DS_Toggle_Master__c=FALSE;
         ds.DSE__DS_No_Duplicate__c=TRUE;
         ds.Manual_Merge_Required__c=TRUE;
         ds.Auto_Merged__c=FALSE;
      
     }
  }
  
// Block 10 Master is Merged record   and duplicate is Zebra Contact 

    else if ((ds.EVM_Contact_ID_of_Master__c!= null && ds.EVM_Contact_ID_of_Master__c!='')
     && 
   (ds.AIT_Contact_ID_of_Master__c != null && ds.AIT_Contact_ID_of_Master__c !='')
     && 
   (ds.AIT_Contact_ID_of_Duplicate__c==null || ds.AIT_Contact_ID_of_Duplicate__c =='') 
     && 
   (ds.EVM_Contact_ID_of_Duplicate__c ==''|| ds.EVM_Contact_ID_of_Duplicate__c == null))
 {
     
    ds.DSE__DS_Toggle_Master__c=False;
    ds.DSE__DS_No_Duplicate__c=FALSE;
    ds.Manual_Merge_Required__c=false;
    ds.Auto_Merged__c=true;
   
}


// Block 11 Master is Zebra Contact  and duplicate is Merged Record 

     else if ((ds.EVM_Contact_ID_of_Master__c== null || ds.EVM_Contact_ID_of_Master__c=='')
     && 
    (ds.AIT_Contact_ID_of_Master__c == null  || ds.AIT_Contact_ID_of_Master__c =='')
     && 
    (ds.AIT_Contact_ID_of_Duplicate__c!=null && ds.AIT_Contact_ID_of_Duplicate__c !='') 
     && 
    (ds.EVM_Contact_ID_of_Duplicate__c !=''&& ds.EVM_Contact_ID_of_Duplicate__c != null))
 {    
    
     ds.DSE__DS_Toggle_Master__c=True;
     ds.DSE__DS_No_Duplicate__c=FALSE;
     ds.Manual_Merge_Required__c=False;
     ds.Auto_Merged__c=True;
    
 }
 
 // Block 12 Master is Merged record   and duplicate is Enterprise Contact

  else if ((ds.EVM_Contact_ID_of_Master__c!= null && ds.EVM_Contact_ID_of_Master__c!='')
     && 
   (ds.AIT_Contact_ID_of_Master__c != null && ds.AIT_Contact_ID_of_Master__c !='')
     && 
   (ds.AIT_Contact_ID_of_Duplicate__c==null || ds.AIT_Contact_ID_of_Duplicate__c =='') 
     && 
   (ds.EVM_Contact_ID_of_Duplicate__c !=''&& ds.EVM_Contact_ID_of_Duplicate__c != null))
 {
    
    ds.DSE__DS_Toggle_Master__c=False;
    ds.DSE__DS_No_Duplicate__c=True;
    ds.Manual_Merge_Required__c=true;
    ds.Auto_Merged__c=false;
  
 }
 
 // Block 13 Master is Enterprise record   and duplicate is Merged 

  else if ((ds.EVM_Contact_ID_of_Master__c!= null && ds.EVM_Contact_ID_of_Master__c!='')
     && 
   (ds.AIT_Contact_ID_of_Master__c == null || ds.AIT_Contact_ID_of_Master__c =='')
     && 
   (ds.AIT_Contact_ID_of_Duplicate__c!=null && ds.AIT_Contact_ID_of_Duplicate__c !='') 
     && 
   (ds.EVM_Contact_ID_of_Duplicate__c !=''&& ds.EVM_Contact_ID_of_Duplicate__c != null))
 {  
   
    ds.DSE__DS_Toggle_Master__c=False;
    ds.DSE__DS_No_Duplicate__c=True;
    ds.Manual_Merge_Required__c=true;
    ds.Auto_Merged__c=false;
   
 }
 // Block 14 Master is Merged record   and duplicate is Siebel

  else if ((ds.EVM_Contact_ID_of_Master__c!= null && ds.EVM_Contact_ID_of_Master__c!='')
     && 
   (ds.AIT_Contact_ID_of_Master__c != null && ds.AIT_Contact_ID_of_Master__c !='')
     && 
   (ds.AIT_Contact_ID_of_Duplicate__c!=null && ds.AIT_Contact_ID_of_Duplicate__c !='') 
     && 
   (ds.EVM_Contact_ID_of_Duplicate__c ==''|| ds.EVM_Contact_ID_of_Duplicate__c == null))
 {
   
    ds.DSE__DS_Toggle_Master__c=False;
    ds.DSE__DS_No_Duplicate__c=True;
    ds.Manual_Merge_Required__c=true;
    ds.Auto_Merged__c=false;
   
 }

 // Block 15 Master is Siebel record   and duplicate is Merged
 
  else if ((ds.EVM_Contact_ID_of_Master__c== null || ds.EVM_Contact_ID_of_Master__c=='')
     && 
   (ds.AIT_Contact_ID_of_Master__c != null && ds.AIT_Contact_ID_of_Master__c !='')
     && 
   (ds.AIT_Contact_ID_of_Duplicate__c!=null && ds.AIT_Contact_ID_of_Duplicate__c !='') 
     && 
   (ds.EVM_Contact_ID_of_Duplicate__c !=''&& ds.EVM_Contact_ID_of_Duplicate__c != null))
 { 
  
    ds.DSE__DS_Toggle_Master__c=False;
    ds.DSE__DS_No_Duplicate__c= True;
    ds.Manual_Merge_Required__c=true;
    ds.Auto_Merged__c=false;
   
 }
 
 // Block 16 Master is Merged record   and duplicate is Merged
 
  else if ((ds.EVM_Contact_ID_of_Master__c!= null && ds.EVM_Contact_ID_of_Master__c!='')
     && 
   (ds.AIT_Contact_ID_of_Master__c != null && ds.AIT_Contact_ID_of_Master__c !='')
     && 
   (ds.AIT_Contact_ID_of_Duplicate__c!=null && ds.AIT_Contact_ID_of_Duplicate__c !='') 
     && 
   (ds.EVM_Contact_ID_of_Duplicate__c !=''&& ds.EVM_Contact_ID_of_Duplicate__c != null))
 {
   
    ds.DSE__DS_Toggle_Master__c=False;
    ds.DSE__DS_No_Duplicate__c= True;
    ds.Manual_Merge_Required__c=true;
    ds.Auto_Merged__c=false;
  
 }
}
else if ((ds.Account_Id_of_Master__c!=ds.Account_Id_of_Duplicate__c)
     || (ds.DSE__DS_Source_Master__c!='Contact'|| ds.DSE__DS_Source_Duplicate__c !='Contact')
     || (ds.Email_of_Master__c!=ds.Email_of_Duplicate__c))
     {
  
    ds.DSE__DS_Toggle_Master__c=False;
    ds.DSE__DS_No_Duplicate__c= True;
    ds.Manual_Merge_Required__c=False;
    ds.Auto_Merged__c=FALSE;
  
    }
}
}