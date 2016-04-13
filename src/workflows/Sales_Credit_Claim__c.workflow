<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Credit Claim Completed Notification</fullName>
        <ccEmails>Chris.Webb@zebra.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Requestor_Area_Controller__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Requestor_Manager__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Sales_Credit_Claim_Templates/Sales_Credit_Claim_Completed_Rejection_Notification</template>
    </alerts>
    <alerts>
        <fullName>Sales Credit Claim Rejection</fullName>
        <ccEmails>Chris.Webb@zebra.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Approving_AC__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Approving_RSM__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Requestor__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Sales_Credit_Claim_Templates/Sales_Credit_Claim_Completed_Rejection_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Credit Claim Status Update to Completed</fullName>
        <field>Status__c</field>
        <literalValue>Completed</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Modify Status</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status Validated By Area Controller</fullName>
        <field>Status__c</field>
        <literalValue>Validated</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status Validated by FTO</fullName>
        <field>Status__c</field>
        <literalValue>Validated</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status Validated by RSM</fullName>
        <field>Status__c</field>
        <literalValue>Validated</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Current Approver as Approved</fullName>
        <field>Current_Approver__c</field>
        <literalValue>Approved</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Current Approver as Area%2FFinancia</fullName>
        <field>Current_Approver__c</field>
        <literalValue>Financial Controller</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Current Approver as Field Operati</fullName>
        <field>Current_Approver__c</field>
        <literalValue>SIP Team</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Current Approver as RSM</fullName>
        <field>Current_Approver__c</field>
        <literalValue>Sales Manager</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Status Date</fullName>
        <field>Status_Date__c</field>
        <formula>Today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Status to Submitted</fullName>
        <field>Status__c</field>
        <literalValue>Submitted</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
