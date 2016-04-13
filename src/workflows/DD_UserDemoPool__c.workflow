<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Demo - Update Unique Fld UserDemoPool</fullName>
        <field>Unique_User_Demo_Pool__c</field>
        <formula>DD_Demo_Pool__r.Name &amp; &quot;-&quot; &amp; DD_User__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Demo - Restrict Duplicate users assigment to Demo Pool</fullName>
        <actions>
            <name>Demo - Update Unique Fld UserDemoPool</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
