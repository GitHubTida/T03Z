<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email notification will be sent if added as Sales Team Member</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>GSS Account Manager/Engagement Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <template>All/Opportunity_Team_Email</template>
    </alerts>
    <rules>
        <fullName>Added to Sales Team</fullName>
        <actions>
            <name>Email notification will be sent if added as Sales Team Member</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Notification to User when added to Sales Team</description>
        <formula>ISPICKVAL( TeamMemberRole , &apos;GSS Account Manager/Engagement Manager&apos;)&amp;&amp; NOT( $Setup.RulesDeactivateSwitch__c.Opportunity_Switch__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
