/*
 * File Name     : OppChannelPartnerTrigger
 * Description   : This trigger is used for Updating Opportunities when associated
 *                 Channel Partner record is inserted or updated or deleted.
 * Modification Log
 * =============================================================================
 *   Ver     Date           Author                   Modification
 * -----------------------------------------------------------------------------
 *   1.0     05-Mar-2015    Bharathi Selvaraj        Initial Creation
 */

trigger OppChannelPartnerTrigger on OpportunityPatner__c (after insert, before update, before delete) {
    TriggerDeactivateSwitch__c objTriggerDeactivate = TriggerDeactivateSwitch__c.getValues('Opportunity');
    if(objTriggerDeactivate.IsTriggerActive__c){

        Set<Id> opps = new Set<Id>();
        Set<Id> acts = new Set<Id>();
        Set<Id> PartnerIds = new Set<Id>();

        OpportunityPatner__c[] ps = Trigger.new;
        OpportunityPatner__c[] ps1 = Trigger.old;

        if(Trigger.isInsert || Trigger.isUpdate){
            for(OpportunityPatner__c p : ps){
                opps.add(p.Opportunity__c);
                acts.add(p.Patner__c);
                PartnerIds.add(p.Id);
            }
        }
        if(Trigger.isDelete){
            for(OpportunityPatner__c p : ps1){
                opps.add(p.Opportunity__c);
                acts.add(p.Patner__c);
                PartnerIds.add(p.Id);
            }
        }

        //query all pre-existing partner records for the opps involved
        OpportunityPatner__c[] FormerPartners = [Select Id, Opportunity__c, Patner__c, Role__c from OpportunityPatner__c where Opportunity__c in :opps];

        for(OpportunityPatner__c p3 : FormerPartners){
            acts.add(p3.Patner__c);
        }

        //query all accounts involved and map id to ownerid  ALSO get any 'Co-Owner's on Account Team
        Map<Id, Account> AO = new Map<Id, Account>([Select Id, Name,Owner.FirstName, OwnerId, Owner.IsActive,(Select UserId, TeamMemberRole, User.isActive from AccountTeamMembers where User.isActive=TRUE Limit 1) from Account where Id in :acts]);
        
        //query all pre-existing team members for the opps involved
        OpportunityTeamMember[] PreExistingTeamMembers = [Select Id, TeamMemberRole, UserId, OpportunityId from OpportunityTeamMember where OpportunityId in :opps];
        
        Boolean flag;
        Id owner;
        OpportunityTeamMember[] NewTeamMembers = new OpportunityTeamMember[0];
        Opportunity[] UpdatedOpps = new Opportunity[0];
        Set<Id> UO = new Set<Id>();
        Set<Id> newPC = new Set<Id>();
        Set<Id> newPD = new Set<Id>();
        Set<Id> newPCZ = new Set<Id>();
        Set<Id> newPDZ = new Set<Id>();
        Set<Id> newPCar = new Set<Id>();

        if(Trigger.isInsert){
            for(OpportunityPatner__c p2 : ps){
                //This block adds the owner of the partner to the sales team
               //Check for if first name blank (generic user)
                if(AO.containsKey(p2.Patner__c)){
                    if(AO.get(p2.Patner__c).Owner.FirstName != null && AO.get(p2.Patner__c).Owner.FirstName != '' && AO.get(p2.Patner__c).Owner.IsActive){
                        //Check if owner is on sales team, if not add them to list for addition
                        flag=false;
                        owner=AO.get(p2.Patner__c).OwnerId;

                        for(OpportunityTeamMember otm : PreExistingTeamMembers){
                            if(otm.UserId==owner && otm.OpportunityId==p2.Opportunity__c){
                                flag=true;
                            }
                        }
                        if(!flag){
                            if(p2.Role__c=='Primary Distributor' || p2.Role__c=='Primary Distributor AIT')
                                NewTeamMembers.add(new OpportunityTeamMember(UserId=owner,OpportunityId=p2.Opportunity__c,TeamMemberRole='DCAM'));
                            else
                                NewTeamMembers.add(new OpportunityTeamMember(UserId=owner,OpportunityId=p2.Opportunity__c,TeamMemberRole='Channel Account Manager'));
                        }
                    }

                    //If Primary, need to create opp record for updating header field (check for duplicate opp updates)
                    if(p2.Role__c == 'Primary Distributor'){
                        if(!UO.contains(p2.Opportunity__c)){
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Opportunity_Distributor__c=AO.get(p2.Patner__c).Id));
                            UO.add(p2.Opportunity__c);
                        }
                        else{
                            for(Opportunity oppty : UpdatedOpps){
                                if(oppty.Id==p2.Opportunity__c){
                                    oppty.Opportunity_Distributor__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                    }
                    else if(p2.Role__c == 'Primary Channel Partner'){
                        if(!UO.contains(p2.Opportunity__c)){
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Opportunity_Reseller__c=AO.get(p2.Patner__c).Id));
                            UO.add(p2.Opportunity__c);
                        }
                        else{
                            for(Opportunity oppty2 : UpdatedOpps){
                                if(oppty2.Id==p2.Opportunity__c){
                                    oppty2.Opportunity_Reseller__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                    }
                    else if(p2.Role__c == 'Primary Distributor AIT'){
                        if(!UO.contains(p2.Opportunity__c)){
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Distributor_AIT__c=AO.get(p2.Patner__c).Id));
                            UO.add(p2.Opportunity__c);
                        }
                        else{
                            for(Opportunity oppty3 : UpdatedOpps){
                                if(oppty3.Id==p2.Opportunity__c){
                                    oppty3.Primary_Distributor_AIT__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                    }
                    else if(p2.Role__c == 'Primary Channel Partner AIT'){
                        if(!UO.contains(p2.Opportunity__c)){
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Channel_Partner_AIT__c=AO.get(p2.Patner__c).Id));
                            UO.add(p2.Opportunity__c);
                        }
                        else{
                            for(Opportunity oppty4 : UpdatedOpps){
                                if(oppty4.Id==p2.Opportunity__c){
                                    oppty4.Primary_Channel_Partner_AIT__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                    }
                    else if(p2.Role__c == 'Primary Carrier'){
                        if(!UO.contains(p2.Opportunity__c)){
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Carrier__c=AO.get(p2.Patner__c).Id));
                            UO.add(p2.Opportunity__c);
                        }
                        else{
                            for(Opportunity oppty4 : UpdatedOpps){
                                if(oppty4.Id==p2.Opportunity__c){
                                    oppty4.Primary_Carrier__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            //Create new team member records
            if(NewTeamMembers.size()>0)
                insert NewTeamMembers;
        }

        if(Trigger.isUpdate){
            //query all pre-existing partner records for the opps involved
            OpportunityPatner__c[] FormerPrimaryPartners = [Select Id, Opportunity__c, Patner__c, Role__c from OpportunityPatner__c where Opportunity__c in :opps and Role__c like 'Primary%'];

            for(OpportunityPatner__c p2 : ps){
                //If Primary, need to create opp record for updating header field (check for duplicate opp updates)
                if(AO.containsKey(p2.Patner__c)){
                    if(p2.Role__c == 'Primary Distributor'){
                        if(newPC.contains(p2.Opportunity__c) || newPCZ.contains(p2.Opportunity__c) || newPDZ.contains(p2.Opportunity__c)){
                            for(Opportunity uo1 : UpdatedOpps){
                                if(uo1.Id==p2.Opportunity__c){
                                    uo1.Opportunity_Distributor__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Opportunity_Distributor__c=AO.get(p2.Patner__c).Id));
                        }
                        newPD.add(p2.Opportunity__c);
                    }
                    else if(p2.Role__c == 'Primary Channel Partner'){
                        if(newPD.contains(p2.Opportunity__c) || newPCZ.contains(p2.Opportunity__c) || newPDZ.contains(p2.Opportunity__c) ){
                            for(Opportunity uo2 : UpdatedOpps){
                                if(uo2.Id==p2.Opportunity__c){
                                    uo2.Opportunity_Reseller__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Opportunity_Reseller__c=AO.get(p2.Patner__c).Id));
                        }
                        newPC.add(p2.Opportunity__c);
                    }
                    else if(p2.Role__c == 'Primary Channel Partner AIT'){
                        if(newPD.contains(p2.Opportunity__c) || newPC.contains(p2.Opportunity__c) || newPDZ.contains(p2.Opportunity__c) ){
                            for(Opportunity uo3 : UpdatedOpps){
                                if(uo3.Id==p2.Opportunity__c){
                                    uo3.Primary_Channel_Partner_AIT__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Channel_Partner_AIT__c=AO.get(p2.Patner__c).Id));
                        }
                        newPCZ.add(p2.Opportunity__c);
                    }
                    else if(p2.Role__c == 'Primary Distributor AIT'){
                        if(newPD.contains(p2.Opportunity__c) || newPC.contains(p2.Opportunity__c) || newPCZ.contains(p2.Opportunity__c) ){
                            for(Opportunity uo4 : UpdatedOpps){
                                if(uo4.Id==p2.Opportunity__c){
                                    uo4.Primary_Distributor_AIT__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Distributor_AIT__c=AO.get(p2.Patner__c).Id));
                        }
                        newPDZ.add(p2.Opportunity__c);
                    }
                    else if(p2.Role__c == 'Primary Carrier'){
                        if(newPD.contains(p2.Opportunity__c) || newPC.contains(p2.Opportunity__c) || newPCZ.contains(p2.Opportunity__c) ){
                            for(Opportunity uo4 : UpdatedOpps){
                                if(uo4.Id==p2.Opportunity__c){
                                    uo4.Primary_Carrier__c=AO.get(p2.Patner__c).Id;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Carrier__c=AO.get(p2.Patner__c).Id));
                        }
                        newPDZ.add(p2.Opportunity__c);
                    }

                }
            }

            //need to clear out PCP or PD if none is selected anymore
            //i.e. where in 'opps' but not in 'updated opps'
            Boolean found;
            for(Id topp : opps){
                found=false;
                if(!newPC.contains(topp)){
                    for(OpportunityPatner__c tpart : FormerPrimaryPartners){
                        if(tpart.Opportunity__c==topp && tpart.Role__c=='Primary Channel Partner'  && !PartnerIds.contains(tpart.Id)){
                            found=true;
                            break;
                        }
                    }
                    if(!found){
                        if(newPD.contains(topp) || newPCZ.contains(topp) || newPDZ.contains(topp)){
                            for(Opportunity uo2 : UpdatedOpps){
                                if(uo2.Id==topp){
                                    uo2.Opportunity_Reseller__c=null;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=topp,Opportunity_Reseller__c=null));
                        }
                    }
                    newPC.add(topp);
                }
                found=false;
                if(!newPD.contains(topp)){
                    for(OpportunityPatner__c tpart1 : FormerPrimaryPartners){
                        if(tpart1.Opportunity__c==topp && tpart1.Role__c=='Primary Distributor'  && !PartnerIds.contains(tpart1.Id)){
                            found=true;
                            break;
                        }
                    }
                    if(!found){
                        if(newPC.contains(topp) ||  newPCZ.contains(topp) || newPDZ.contains(topp)){
                            for(Opportunity uo3 : UpdatedOpps){
                                if(uo3.Id==topp){
                                    uo3.Opportunity_Distributor__c=null;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=topp,Opportunity_Distributor__c=null));
                        }
                    }
                    newPD.add(topp);
                }
                found=false;
                if(!newPCZ.contains(topp)){
                    for(OpportunityPatner__c tpart2 : FormerPrimaryPartners){
                        if(tpart2.Opportunity__c==topp && tpart2.Role__c=='Primary Channel Partner AIT'  && !PartnerIds.contains(tpart2.Id)){
                            found=true;
                            break;
                        }
                    }
                    if(!found){
                        if(newPC.contains(topp) || newPD.contains(topp)|| newPDZ.contains(topp)){
                            for(Opportunity uo4 : UpdatedOpps){
                                if(uo4.Id==topp){
                                    uo4.Primary_Channel_Partner_AIT__c=null;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=topp,Primary_Channel_Partner_AIT__c=null));
                        }
                    }
                    newPCZ.add(topp);
                }
                found=false;
                if(!newPDZ.contains(topp)){
                    for(OpportunityPatner__c tpart3 : FormerPrimaryPartners){
                        if(tpart3.Opportunity__c==topp && tpart3.Role__c=='Primary Distributor AIT'  && !PartnerIds.contains(tpart3.Id)){
                            found=true;
                            break;
                        }
                    }
                    if(!found){
                        if(newPC.contains(topp) || newPD.contains(topp)|| newPCZ.contains(topp)){
                            for(Opportunity uo4 : UpdatedOpps){
                                if(uo4.Id==topp){
                                    uo4.Primary_Distributor_AIT__c=null;
                                    break;
                                }
                            }
                        }
                        else{
                            UpdatedOpps.add(new Opportunity(Id=topp,Primary_Distributor_AIT__c=null));
                        }
                    }
                    newPDZ.add(topp);
                }
            }
        }

        if(Trigger.isDelete){

            OpportunityTeamMember[] DeletedTeamMembers = new OpportunityTeamMember[0];
            Boolean multiowner;

            for(OpportunityPatner__c p2 : ps1){
                //If Primary, need to create opp record for updating header field (check for duplicate opp updates)
                if(p2.Role__c == 'Primary Distributor'){
                    if(newPC.contains(p2.Opportunity__c) || newPCZ.contains(p2.Opportunity__c) || newPDZ.contains(p2.Opportunity__c)){
                        for(Opportunity uo1 : UpdatedOpps){
                            if(uo1.Id==p2.Opportunity__c){
                                uo1.Opportunity_Distributor__c=null;
                                break;
                            }
                        }
                    }
                    else{
                        UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Opportunity_Distributor__c=null));
                    }
                    newPD.add(p2.Opportunity__c);
                }
                else if(p2.Role__c == 'Primary Channel Partner'){
                    if(newPD.contains(p2.Opportunity__c) || newPCZ.contains(p2.Opportunity__c) || newPDZ.contains(p2.Opportunity__c) ){
                        for(Opportunity uo2 : UpdatedOpps){
                            if(uo2.Id==p2.Opportunity__c){
                                uo2.Opportunity_Reseller__c=null;
                                break;
                            }
                        }
                    }
                    else{
                        UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Opportunity_Reseller__c=null));
                    }
                    newPC.add(p2.Opportunity__c);
                }
                else if(p2.Role__c == 'Primary Channel Partner AIT'){
                    if(newPD.contains(p2.Opportunity__c) || newPC.contains(p2.Opportunity__c) || newPDZ.contains(p2.Opportunity__c) ){
                        for(Opportunity uo3 : UpdatedOpps){
                            if(uo3.Id==p2.Opportunity__c){
                                uo3.Primary_Channel_Partner_AIT__c=null;
                                break;
                            }
                        }
                    }
                    else{
                        UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Channel_Partner_AIT__c=null));
                    }
                    newPCZ.add(p2.Opportunity__c);
                }
                else if(p2.Role__c == 'Primary Distributor AIT'){
                    if(newPD.contains(p2.Opportunity__c) || newPC.contains(p2.Opportunity__c) || newPCZ.contains(p2.Opportunity__c) ){
                        for(Opportunity uo4 : UpdatedOpps){
                            if(uo4.Id==p2.Opportunity__c){
                                uo4.Primary_Distributor_AIT__c=null;
                                break;
                            }
                        }
                    }
                    else{
                        UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Distributor_AIT__c=null));
                    }
                    newPDZ.add(p2.Opportunity__c);
                }
                
                else if(p2.Role__c == 'Primary Carrier'){
                    if(newPD.contains(p2.Opportunity__c) || newPC.contains(p2.Opportunity__c) || newPCZ.contains(p2.Opportunity__c) ){
                        for(Opportunity uo5 : UpdatedOpps){
                            if(uo5.Id==p2.Opportunity__c){
                                uo5.Primary_Carrier__c=null;
                                break;
                            }
                        }
                    }
                    else{
                        UpdatedOpps.add(new Opportunity(Id=p2.Opportunity__c,Primary_Carrier__c=null));
                    }
                    //newPDZ.add(p2.Opportunity__c);
                }

                //If owner do not own other surviving partners... remove them
                multiowner=false;

                for(OpportunityPatner__c px : FormerPartners){
                    if(!PartnerIds.contains(px.Id) && p2.Patner__c!=null && px.Patner__c!=null){

                        if(AO.get(px.Patner__c).OwnerId==AO.get(p2.Patner__c).OwnerId){
                            multiowner=true;
                        }
                        else if(AO.get(px.Patner__c).AccountTeamMembers.size()>0){
                            if(AO.get(px.Patner__c).AccountTeamMembers[0].UserId==AO.get(p2.Patner__c).OwnerId){
                                multiowner=true;
                            }
                        }
                    }
                }
                if(!multiowner && p2.Patner__c!=null){
                    for(OpportunityTeamMember otm : PreExistingTeamMembers){
                        if(otm.OpportunityId==p2.Opportunity__c && otm.UserId==AO.get(p2.Patner__c).OwnerId){
                            DeletedTeamMembers.add(otm);
                            break;
                        }
                    }
                }
            }
            Set<OpportunityTeamMember> SetOFOppTeamMembers = new Set<OpportunityTeamMember>();
            SetOFOppTeamMembers.addAll(DeletedTeamMembers);
            DeletedTeamMembers = new List<OpportunityTeamMember>();
            DeletedTeamMembers.addAll(SetOFOppTeamMembers);
            //Delete team members
            if(DeletedTeamMembers.size()>0)
                delete DeletedTeamMembers;
        }

        //Update Opps
        if(UpdatedOpps.size()>0)
            update UpdatedOpps;
    }
}