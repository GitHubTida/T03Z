<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Notification of Execution</fullName>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <template>Target_Account_Templates/Execution_Notification</template>
    </alerts>
    <alerts>
        <fullName>Target Account Approval Notification</fullName>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <template>Target_Account_Templates/Approval_Notification</template>
    </alerts>
    <alerts>
        <fullName>Target Account Rejection Notification</fullName>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <template>Target_Account_Templates/Rejection_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>Mod Status to Approved</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mod Status to Rejected</fullName>
        <field>Status__c</field>
        <literalValue>Rejected</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mod Status to Submitted - Field Ops</fullName>
        <field>Status__c</field>
        <literalValue>Submitted - Field Ops</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mod Status to Submitted AC</fullName>
        <field>Status__c</field>
        <literalValue>Submitted - AC</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mod Status to Submitted AM</fullName>
        <field>Status__c</field>
        <literalValue>Submitted - AM</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mod Status to Submitted RSM</fullName>
        <field>Status__c</field>
        <literalValue>Submitted - RSM</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Execution Notification</fullName>
        <actions>
            <name>Notification of Execution</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Modification__c.Status__c</field>
            <operation>equals</operation>
            <value>Executed</value>
        </criteriaItems>
        <description>Notifies requester when a Target Account is modified as per their request.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
