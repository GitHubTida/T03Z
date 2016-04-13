<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>SR %2F DR Approval Notification</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>SolutionRewardsDealRegistration/SRDREmailTemplateApprovalNotification</template>
    </alerts>
    <alerts>
        <fullName>SR %2F DR Rejection Notice</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>SolutionRewardsDealRegistration/SRDREmailTemplateRejectionNotification</template>
    </alerts>
    <alerts>
        <fullName>SR DR Email to 3rd Party</fullName>
        <ccEmails>bwd637@zebra.com</ccEmails>
        <ccEmails>nsharma2@zebra.com</ccEmails>
        <protected>false</protected>
        <template>SolutionRewardsDealRegistration/Notify_Deals_Desk_of</template>
    </alerts>
    <fieldUpdates>
        <fullName>Deal Registration Expiration Field Updat</fullName>
        <field>Tracking_Status__c</field>
        <formula>&quot;Expired&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SR %2F DR Status Update</fullName>
        <field>Tracking_Status__c</field>
        <formula>&quot;Approved&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SR %2F DR Status Update Rejection</fullName>
        <field>Tracking_Status__c</field>
        <formula>&quot;Rejected&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SR DR - Awaiting ASL Approval</fullName>
        <field>Tracking_Status__c</field>
        <formula>&quot;Awaiting ASL Approval&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SR DR - Awaiting RCM Approval</fullName>
        <field>Tracking_Status__c</field>
        <formula>&quot;Awaiting RCM Approval&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SR DR - Awaiting RSM Approval</fullName>
        <field>Tracking_Status__c</field>
        <formula>&quot;Awaiting RSM Approval&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Deal Registration Expiration Warning</fullName>
        <actions>
            <name>Deal Registration Expiration Field Updat</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>SR_DR__c.Tracking_Status__c</field>
            <operation>contains</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>SR_DR__c.Expiration_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
