<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>CHAM notification of approval</fullName>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <template>Channel_Ops/CHAM_Preapproval_notification</template>
    </alerts>
    <alerts>
        <fullName>CHAM notification of rejection</fullName>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <template>Channel_Ops/CHAM_Rejection_notification</template>
    </alerts>
    <alerts>
        <fullName>Cham Account Requalification</fullName>
        <protected>false</protected>
        <recipients>
            <type>accountOwner</type>
        </recipients>
        <template>Channel_Ops/Partner_Profile_Requal_Submission</template>
    </alerts>
    <alerts>
        <fullName>Channel Ops submission notification</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>cprograms@zebra.com.t03sfdc</recipient>
            <type>user</type>
        </recipients>
        <template>Channel_Ops/Partner_Profile_Requal_Submission</template>
    </alerts>
    <alerts>
        <fullName>Partner program preapproved</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>PF Program Membership Admin</recipient>
            <type>accountTeam</type>
        </recipients>
        <template>Channel_Ops/Reseller_Program_PreApproved</template>
    </alerts>
    <alerts>
        <fullName>on-boarding prospect rejection notificatoin</fullName>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <template>Channel_Ops/On_boarding_rejection_notification</template>
    </alerts>
    <tasks>
        <fullName>Re-qualification Submission Review</fullName>
        <assignedTo>cprograms@zebra.com.t03sfdc</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>3</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
    </tasks>
</Workflow>
