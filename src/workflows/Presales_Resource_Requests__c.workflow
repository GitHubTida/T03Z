<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email Notifiaction- Pre Sales Requests</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>mgh638@zebra.com.t03sfdc</recipient>
            <type>user</type>
        </recipients>
        <template>All/PSRR_Notification</template>
    </alerts>
    <rules>
        <fullName>Email Notification On Presales Resource Request</fullName>
        <actions>
            <name>Email Notifiaction- Pre Sales Requests</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>For the Presales Resource Request object, can we please add a workflow that will email Marie Iorio.</description>
        <formula>NOT(ISBLANK( CreatedDate ) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
