<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Demo Depot - Reserved Product ExternalID</fullName>
        <field>IR_Number_External_Id__c</field>
        <formula>IR_Number__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Demo Depot - Reserved Product External Id</fullName>
        <actions>
            <name>Demo Depot - Reserved Product ExternalID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>DD_Reserved_Product__c.IR_Number__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
