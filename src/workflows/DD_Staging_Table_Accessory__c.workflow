<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Staging table Accessory - External Id</fullName>
        <field>External_Id__c</field>
        <formula>text(FSR_Call_Num__c) +  FSR_Solution__c + FSRL_Part_Num__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Staging table Accessory - External Id</fullName>
        <actions>
            <name>Staging table Accessory - External Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>DD_Staging_Table_Accessory__c.FSR_Solution__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>DD_Staging_Table_Accessory__c.FSR_Call_Num__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>DD_Staging_Table_Accessory__c.FSRL_Part_Num__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
