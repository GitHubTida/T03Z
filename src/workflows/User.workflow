<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Cloud MDM Profile to General User</fullName>
        <field>DSE__DS_Data_Scout_Profile__c</field>
        <formula>&quot;General User&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Cloud MDM Profile</fullName>
        <actions>
            <name>Cloud MDM Profile to General User</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>User.DSE__DS_Data_Scout_Profile__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
