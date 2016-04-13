<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>DR Approval Notification APAC</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approved_APAC</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Notification APAC Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approved_APAC_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Notification EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approved_EMEA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Notification EMEA Internal</fullName>
        <ccEmails>rel2dr.emeaqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approved_EMEA_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Notification LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approved_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Notification LATAM Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approved_LATAM_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Notification NA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approved_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Notification NA Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approved_NA_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Request Notification to Admin</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>NA DR ADMIN QUEUE</recipient>
            <type>group</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approval_Request_APAC_LATAM_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Request Notification to Deal Desk Approver</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>EMEA Deal Desk Approver Queue</recipient>
            <type>group</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approval_Request_EMEA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Request Notification to Level2 Approver</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approval_Request_APAC_LATAM_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Request Notification to Level2 Approver  EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approval_Request_EMEA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Request Notification to Level3 Approver</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approval_Request_APAC_LATAM_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Request Notification to Queue Approver APAC</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>APAC DR Admin Queue</recipient>
            <type>group</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approval_Request_APAC_LATAM_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Request Notification to Queue Approver LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>LATAM DR ADMIN QUEUE</recipient>
            <type>group</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approval_Request_APAC_LATAM_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Approval Request Notification to Queue Approver NA</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>NA DR ADMIN QUEUE</recipient>
            <type>group</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Approval_Request_APAC_LATAM_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification APAC</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification APAC Extended DR</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expirat_Warning_APAC_NA_LATAM_Ext_DR</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification APAC Internal</fullName>
        <ccEmails>rel2dr.apacqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_APAC_NA_LA_Int</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification APAC Internal Extended DR</fullName>
        <ccEmails>rel2dr.apacqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expire_Warn_APAC_NA_LA_Int_Ext_DR</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_EMEA</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification EMEA  Internal Extended DR</fullName>
        <ccEmails>rel2dr.emeaqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_EMEA_Int_Ext_DR</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification EMEA Extended DR</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_EMEA_Ext_DR</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification EMEA Internal</fullName>
        <ccEmails>rel2dr.emeaqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_EMEA_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification LATAM Extended DR</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expirat_Warning_APAC_NA_LATAM_Ext_DR</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification LATAM Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_NA__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_APAC_NA_LA_Int</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification LATAM Internal Extended DR</fullName>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_NA__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expire_Warn_APAC_NA_LA_Int_Ext_DR</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification NA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification NA  Internal Extended DR</fullName>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_NA__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expire_Warn_APAC_NA_LA_Int_Ext_DR</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification NA Extended DR</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expirat_Warning_APAC_NA_LATAM_Ext_DR</template>
    </alerts>
    <alerts>
        <fullName>DR Expiration Remainder Notification NA Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_NA__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expiration_Warning_APAC_NA_LA_Int</template>
    </alerts>
    <alerts>
        <fullName>DR Expired Notification APAC</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expired_Notice_APAC_NA_LATAM_Partner</template>
    </alerts>
    <alerts>
        <fullName>DR Expired Notification APAC Internal</fullName>
        <ccEmails>rel2dr.apacqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expired_Notice_APAC_NA_LATAM_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Expired Notification EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expired_Notice_EMEA_Partner</template>
    </alerts>
    <alerts>
        <fullName>DR Expired Notification EMEA Internal</fullName>
        <ccEmails>rel2dr.emeaqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expired_Notice_EMEA_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Expired Notification LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expired_Notice_APAC_NA_LATAM_Partner</template>
    </alerts>
    <alerts>
        <fullName>DR Expired Notification LATAM Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Opportunity_Owner_NA__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expired_Notice_APAC_NA_LATAM_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Expired Notification NA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expired_Notice_APAC_NA_LATAM_Partner</template>
    </alerts>
    <alerts>
        <fullName>DR Expired Notification NA Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Opportunity_Owner_NA__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Expired_Notice_APAC_NA_LATAM_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Notification APAC</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Approved_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Notification APAC Internal</fullName>
        <ccEmails>rel2dr.apacqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Approved_APAC_NA_LA_Int</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Notification EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Approved_EMEA</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Notification EMEA Internal</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>EMEA Deal Desk Approver Queue</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Approved_EMEA_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Notification LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Approved_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Notification NA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Approved_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Request Notification APAC</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Request_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Request Notification EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>EMEA Deal Desk Approver Queue</recipient>
            <type>group</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Request_EMEA</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Request Notification EMEA Partner</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Request_EMEA_Partner</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Request Notification LATAM</fullName>
        <ccEmails>rel2dr.laqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_NA__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Request_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Approval Request Notification NA</fullName>
        <protected>false</protected>
        <recipients>
            <field>Opportunity_Owner_NA__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Request_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Rejection Notification APAC</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Rejected_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Rejection Notification APAC Internal</fullName>
        <ccEmails>rel2dr.apacqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Rejected_APAC_NA_LA_Int</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Rejection Notification EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Rejected_EMEA</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Rejection Notification EMEA Internal</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>EMEA Deal Desk Approver Queue</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Rejected_EMEA_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Rejection Notification LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Rejected_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Extension Rejection Notification NA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Extension_Rejected_APAC_NA_LATAM</template>
    </alerts>
    <alerts>
        <fullName>DR Rejection Notification APAC</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Rejection</template>
    </alerts>
    <alerts>
        <fullName>DR Rejection Notification APAC Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Level_3_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Rejection_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Rejection Notification EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Rejection</template>
    </alerts>
    <alerts>
        <fullName>DR Rejection Notification EMEA Internal</fullName>
        <ccEmails>rel2dr.emeaqueue@gmail.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Rejection_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Rejection Notification LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Rejection</template>
    </alerts>
    <alerts>
        <fullName>DR Rejection Notification LATAM Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Rejection_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Rejection Notification NA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Rejection</template>
    </alerts>
    <alerts>
        <fullName>DR Rejection Notification NA Internal</fullName>
        <protected>false</protected>
        <recipients>
            <field>Level_2_Approver__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Rejection_Internal</template>
    </alerts>
    <alerts>
        <fullName>DR Successful Submission Notification APAC</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Submission_Acknowledgement_APAC_LA_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Successful Submission Notification EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Submission_Acknowledgement_EMEA</template>
    </alerts>
    <alerts>
        <fullName>DR Successful Submission Notification LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Submission_Acknowledgement_APAC_LA_NA</template>
    </alerts>
    <alerts>
        <fullName>DR Successful Submission Notification Managed CHAM</fullName>
        <protected>false</protected>
        <recipients>
            <field>Managed_CHAM__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Submission_Ack_to_Managed_Cham</template>
    </alerts>
    <alerts>
        <fullName>DR Successful Submission Notification NA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Deal_Registration_Email_Template/DR_Submission_Acknowledgement_APAC_LA_NA</template>
    </alerts>
    <fieldUpdates>
        <fullName>DR Accept%2FReject Update</fullName>
        <description>This is used to update the Accept/Reject Date field of Deal Registration whebnever the deal is approved or rejected.</description>
        <field>Accept_Reject_Date__c</field>
        <formula>Now()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Activation Date Update</fullName>
        <description>This is used to update the DR Activation Dates field of Deal Registration to 10 days from the approved date for APAC and EMEA.</description>
        <field>DR_Activation_Date__c</field>
        <formula>Now()+10</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Approval Status Update Approved-Admin</fullName>
        <description>This is used to update the Approval Status field of Deal Registration to Approved-Admin
once the deal is approved by DR Admin Queue</description>
        <field>Approval_Status__c</field>
        <literalValue>Approved - Admin</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Approval Status Update Approved-Final</fullName>
        <description>This is used to update the Approval Status field of Deal Registration to Approved-Final once the deal is approved by Final level approver.</description>
        <field>Approval_Status__c</field>
        <literalValue>Approved Final</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Approval Status Update to Expired</fullName>
        <description>This is used to update the Approval Status field of Deal Registration to Expired once the Deal expires.</description>
        <field>Approval_Status__c</field>
        <literalValue>Expired</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Approval Status Update to Pending</fullName>
        <description>This is used to update the Approval Status field of Deal Registration to Pending once the Deal is submitted for approval</description>
        <field>Approval_Status__c</field>
        <literalValue>Pending</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Approval Status Update to Rejected</fullName>
        <description>This is used to update the Approval Status field of Deal Registration to Rejected once the Deal is rejected.</description>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Approval Submission  Date Update</fullName>
        <description>This is used to update the Approval Submission Date field of Deal Registration once the deal is submitted for approval</description>
        <field>Approval_Submission_Date__c</field>
        <formula>Now()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR ApprovalStatus Update Approved-Level2</fullName>
        <description>This is used to update the Approval Status field of Deal Registration to Approved-Admin 
once the deal is approved by Second level approver</description>
        <field>Approval_Status__c</field>
        <literalValue>Approved - Level 2</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Current Approver  Update</fullName>
        <field>CurrentApprover__c</field>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Expiration Date Update</fullName>
        <description>This is used to update the DR Expiration Date field of Deal Registration to 180 days from the approved date.</description>
        <field>DR_Expiration_Date__c</field>
        <formula>NOW()+2</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Extension Approve%2FReject Date Update</fullName>
        <description>This is used to update the  Extension Approve/Reject Date field of Deal Registration whenever the deal extension request is approved or rejected.</description>
        <field>Extension_Approve_Reject_Date__c</field>
        <formula>Now()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Extension Status Update NotRequested</fullName>
        <description>This is used to update the Extension Status field of Deal Registration to Not Requested</description>
        <field>Extension_Status__c</field>
        <literalValue>Not Requested</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>DR Extension Submission Date Update</fullName>
        <description>This is used to update the Extension Submission Date  field of Deal Registration whenever extension request is submitted for approval by the Partner Contact</description>
        <field>DR_Expiration_Extension_Submission_Date__c</field>
        <formula>Today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>DR Expiration Handling APAC</fullName>
        <active>true</active>
        <description>This workflow is used to Send email 15 days, 7 days and 1 day prior to expiration as well as on the expiration, and upon expiration it changes the approval status to expired.</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;APAC&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Not Requested&apos;) || ISPICKVAL(Extension_Status__c,&apos;Requested&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling APAC Expiration Ext Rejected</fullName>
        <active>true</active>
        <description>This workflow is used to Send final expiry notification for Extension Rejected DRs</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;APAC&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Rejected&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling APAC Extended DR</fullName>
        <active>true</active>
        <description>This workflow is used to Send email 15 days, 7 days and 1 day prior to expiration as well as on the expiration, and upon expiration it changes the approval status to expired.</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;APAC&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Approved&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling EMEA</fullName>
        <active>true</active>
        <description>This workflow is used to Send email 15 days prior to expiration as well as on the expiration, and upon expiration it changes the approval status to expired.</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp; ISPICKVAL(Partner_Region__c,&apos;EMEA&apos;) &amp;&amp; NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Not Requested&apos;) || ISPICKVAL(Extension_Status__c,&apos;Requested&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling EMEA Expiration Ext Rejected</fullName>
        <active>true</active>
        <description>This workflow is used to Send final expiry notification for Extension Rejected DRs</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;EMEA&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Rejected&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling EMEA Extended DR</fullName>
        <active>true</active>
        <description>This workflow is used to Send email 15 days, 7 days and 1 day prior to expiration as well as on the expiration, and upon expiration it changes the approval status to expired.</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;EMEA&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Approved&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling LATAM</fullName>
        <active>true</active>
        <description>This workflow is used to Send email 15 days prior to expiration as well as on the expiration, and upon expiration it changes the approval status to expired.</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp; ISPICKVAL(Partner_Region__c,&apos;LATAM&apos;) &amp;&amp; NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Not Requested&apos;) || ISPICKVAL(Extension_Status__c,&apos;Requested&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling LATAM Expiration Ext Rejected</fullName>
        <active>true</active>
        <description>This workflow is used to Send final expiry notification for Extension Rejected DRs</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;LATAM&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Rejected&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling LATAM Extended DR</fullName>
        <active>true</active>
        <description>This workflow is used to Send email 15 days, 7 days and 1 day prior to expiration as well as on the expiration, and upon expiration it changes the approval status to expired.</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;LATAM&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Approved&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling NA</fullName>
        <active>true</active>
        <description>This workflow is used to Send email 15 days prior to expiration as well as on the expiration, and upon expiration it changes the approval status to expired.</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp; ISPICKVAL(Partner_Region__c,&apos;NA&apos;) &amp;&amp; NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Not Requested&apos;) || ISPICKVAL(Extension_Status__c,&apos;Requested&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling NA Expiration Ext Rejected</fullName>
        <active>true</active>
        <description>This workflow is used to Send final expiry notification for Extension Rejected DRs</description>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;NA&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Rejected&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Expiration Handling NA Extended DR</fullName>
        <active>true</active>
        <formula>(ISPICKVAL(Opportunity__r.StageName,&apos;Identify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Qualify&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Validate&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Secure&apos;) || ISPICKVAL(Opportunity__r.StageName,&apos;Forecast&apos;)) &amp;&amp;  ISPICKVAL(Partner_Region__c,&apos;NA&apos;) &amp;&amp;  NOT(ISBLANK(DR_Expiration_Date__c)) &amp;&amp; (ISPICKVAL(Extension_Status__c,&apos;Approved&apos;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Approved APAC</fullName>
        <actions>
            <name>DR Extension Approval Notification APAC</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approval Notification APAC Internal</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approve%2FReject Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>APAC Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email when the Deal extension request is approved.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Approved EMEA</fullName>
        <actions>
            <name>DR Extension Approval Notification EMEA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approval Notification EMEA Internal</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approve%2FReject Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>EMEA Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email when the Deal extension request is approved.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Approved LATAM</fullName>
        <actions>
            <name>DR Extension Approval Notification LATAM</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approve%2FReject Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>LATAM Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email when the Deal extension request is approved.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Approved NA</fullName>
        <actions>
            <name>DR Extension Approval Notification NA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approve%2FReject Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>NA Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email when the Deal extension request is approved.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Rejected APAC</fullName>
        <actions>
            <name>DR Extension Rejection Notification APAC</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Rejection Notification APAC Internal</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approve%2FReject Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>APAC Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email when the Deal extension request is rejected and upon rejection it updates Extension Accept/Reject date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Rejected EMEA</fullName>
        <actions>
            <name>DR Extension Rejection Notification EMEA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Rejection Notification EMEA Internal</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approve%2FReject Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>EMEA Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email when the Deal extension request is rejected and upon rejection it updates Extension Accept/Reject date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Rejected LATAM</fullName>
        <actions>
            <name>DR Extension Rejection Notification LATAM</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approve%2FReject Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>LATAM Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email when the Deal extension request is rejected and upon rejection it updates Extension Accept/Reject date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Rejected NA</fullName>
        <actions>
            <name>DR Extension Rejection Notification NA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Approve%2FReject Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>NA Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email when the Deal extension request is rejected and upon rejection it updates Extension Accept/Reject date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Request APAC</fullName>
        <actions>
            <name>DR Extension Approval Request Notification APAC</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Submission Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Requested</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>APAC Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email to the approver when the Deal extension request is raised and updates Extension Status to Requested.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Request EMEA</fullName>
        <actions>
            <name>DR Extension Approval Request Notification EMEA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Submission Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Requested</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>EMEA Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email to the approver when the Deal extension request is raised and updates Extension Status to Requested.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Request LATAM</fullName>
        <actions>
            <name>DR Extension Approval Request Notification LATAM</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Submission Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Requested</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>LATAM Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email to the approver when the Deal extension request is raised and updates Extension Status to Requested.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Extension Request NA</fullName>
        <actions>
            <name>DR Extension Approval Request Notification NA</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>DR Extension Submission Date Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Registration__c.Extension_Status__c</field>
            <operation>equals</operation>
            <value>Requested</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Registration__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>NA Deal Registration</value>
        </criteriaItems>
        <description>This workflow is used to send email to the approver when the Deal extension request is raised and updates Extension Status to Requested.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DR Final Expiration</fullName>
        <active>true</active>
        <description>This workflow is to handle the final expiration of a Deal Registration, irrespective of the status of the Opportunity</description>
        <formula>NOT(ISBLANK(DR_Expiration_Date__c))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
