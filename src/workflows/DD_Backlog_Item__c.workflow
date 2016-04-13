<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Register an Interest %28Notification to Program Admin%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Admin_Email__c</field>
            <type>email</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Register_an_Interest_Notification_to_Program_Admin</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update Admin Email Field</fullName>
        <field>Admin_Email__c</field>
        <formula>Demo_Request__r.DD_Program_Admin__r.Email</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Demo Register an Interest Workflow</fullName>
        <actions>
            <name>Register an Interest %28Notification to Program Admin%29</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>DD_Backlog_Item__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Send Email to the Demo Admin when the user saves the &apos;Register an Interest&apos; request</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Demo Update Admin Email</fullName>
        <actions>
            <name>Update Admin Email Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
