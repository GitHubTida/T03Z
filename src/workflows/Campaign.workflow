<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Campaign - Set Sales Generated</fullName>
        <description>Set the &quot;Sales Generated&quot; flag to True</description>
        <field>Sales_Generated__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Campaign - Set Sales Generated Flag</fullName>
        <actions>
            <name>Campaign - Set Sales Generated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3</booleanFilter>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>Business Operations</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>Marketing Operations</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.ProfileId</field>
            <operation>equals</operation>
            <value>System Administrator</value>
        </criteriaItems>
        <description>This rule checks the &quot;Sales Generated&quot; flag to &quot;True&quot; when a campaign is created by &quot;Business Operations&quot; or Marketing Operations. No marketing campaigns are manually created in Z SFDC &amp; hence the requirement to default  manually created campaigns as SGC</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
