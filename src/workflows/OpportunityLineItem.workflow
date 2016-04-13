<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Is Service Product%3F</fullName>
        <field>Is_Service_Product__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity Product - Update the SKU Fla</fullName>
        <description>This Field Update will happen when an Oppty Line item Entry is created for the SKU</description>
        <field>SKU_Level_Entry__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Is Service Product%3F</fullName>
        <actions>
            <name>Is Service Product%3F</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This field is used to check if the product is service product or not</description>
        <formula>Product2.Is_Service_Product__c = True  &amp;&amp; NOT( $Setup.RulesDeactivateSwitch__c.Opportunity_Switch__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity Product - Update the SKU Flag</fullName>
        <actions>
            <name>Opportunity Product - Update the SKU Fla</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This Field is created to Update the SKU Flag for the SKU level Entries in the Oppty Line Item</description>
        <formula>Product2.SKU_Level_Product__c = TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
