trigger PCAddUserToPublicGrp on OpportunityTeamMember (After insert,After Update) {

    //Set of Userid inside Group
    Set<id> GrpMember = New Set<id>();
    
    //Group Information
    Group Grp=[Select id from Group Where DeveloperName ='PCAllowTeamMemberToSubmitApproval' and Type='Regular'];
    
    //Add into group member
    For(GroupMember GrpMem : [Select groupid,group.DeveloperName,UserOrGroupId from GroupMember where  group.DeveloperName ='PCAllowTeamMemberToSubmitApproval' and group.Type='Regular']){
     GrpMember.Add(GrpMem.UserOrGroupId);
    }
    
    //List of group member to insert
    List<GroupMember> LisGrpMemberToUpdate = New List<GroupMember>();
    
    For(OpportunityTeamMember  OppTeam: Trigger.New){
        
        If(!GrpMember.Contains(OppTeam.UserId)){
        
             GroupMember tempGrp = New GroupMember();
             tempGrp.UserOrGroupId=OppTeam.UserId;
             tempGrp.GroupId=Grp.id;
             LisGrpMemberToUpdate.Add(tempGrp);
            
        }
    
    }
    If(LisGrpMemberToUpdate.Size()>0)
    insert LisGrpMemberToUpdate;
}