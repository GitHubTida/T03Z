<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>PC has been Rejected APAC</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Channel Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>DCAM</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>PC_Related_Templates/ZEB_PC_Rejected_Template_APAC</template>
    </alerts>
    <alerts>
        <fullName>PC has been Rejected EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>Channel Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>DCAM</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>PC_Submitter__c</field>
            <type>userLookup</type>
        </recipients>
        <template>PC_Related_Templates/ZEB_PC_Rejected_Template_EMEA</template>
    </alerts>
    <alerts>
        <fullName>PC has been Rejected NALA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>PC_Related_Templates/ZEB_PC_Rejected_Template_NALA</template>
    </alerts>
    <alerts>
        <fullName>PC has been approved APAC</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Channel Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>DCAM</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>PC_Related_Templates/PC_SendEmail_Reseller_Template_APAC</template>
    </alerts>
    <alerts>
        <fullName>PC has been approved EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>Channel Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>DCAM</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>PC_Submitter__c</field>
            <type>userLookup</type>
        </recipients>
        <template>PC_Related_Templates/ZEB_PC_SendEmail_Reseller_Template_EMEA</template>
    </alerts>
    <alerts>
        <fullName>PC has been approved NALA</fullName>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>PC_Related_Templates/ZEB_PC_SendEmail_Reseller_Template_NA</template>
    </alerts>
    <alerts>
        <fullName>ZEB Email Alert To Account Owner on PC Cancellation</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <template>PC_Related_Templates/ZEB_PC_Cancellation_Notification</template>
    </alerts>
    <alerts>
        <fullName>ZEB Email Alert To Account Owner on PC Expiration</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Owner_Email__c</field>
            <type>email</type>
        </recipients>
        <template>PC_Related_Templates/ZEB_PC_Expiration_Notification</template>
    </alerts>
    <alerts>
        <fullName>ZEB Email Alert To Opportunity Owner on PC Cancellation</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>PC_Related_Templates/ZEB_PC_Cancellation_Notification</template>
    </alerts>
    <fieldUpdates>
        <fullName>APACFinalApproverReadyFalse</fullName>
        <field>APAC_Ready_for_Final_Approver__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>APACFinalApproverReadyTrue</fullName>
        <field>APAC_Ready_for_Final_Approver__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Approved</fullName>
        <field>Status</field>
        <literalValue>Approved</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IsEVM%26AITProcessFalse</fullName>
        <field>Is_EVM_AIT_Process__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IsEVM%26AITProcessTrue</fullName>
        <field>Is_EVM_AIT_Process__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IsInApprovalToFalse</fullName>
        <field>IsInApproval__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IsInApprovalToTrue</fullName>
        <field>IsInApproval__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>L1 Approved</fullName>
        <field>L1Approved__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>L1 Approved False</fullName>
        <field>L1Approved__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>L2 Approved</fullName>
        <field>L2Approved__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>L2 Approved False</fullName>
        <field>L2Approved__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>L3 Approved</fullName>
        <field>L3Approved__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>L3 Approved False</fullName>
        <field>L3Approved__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>L4 Approved</fullName>
        <field>L4Approved__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>L4 Approved False</fullName>
        <field>L4Approved__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Level1Approved</fullName>
        <field>Level1Approved__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Level1ApprovedFalse</fullName>
        <field>Level1Approved__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ManagerApprovedApacNonCard</fullName>
        <field>APAC_Manager_Approved_Non_Card__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ManagerApprovedApacNonCardFalse</fullName>
        <field>APAC_Manager_Approved_Non_Card__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PCStatustoAwaiting Approval</fullName>
        <field>Status</field>
        <literalValue>Awaiting Approval</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PCStatustoAwaiting Cost Information</fullName>
        <field>Status</field>
        <literalValue>Awaiting Cost Information</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PCStatustoAwaiting List Price</fullName>
        <field>Status</field>
        <literalValue>Awaiting List Price</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PCStatustoAwaiting Standard Discount</fullName>
        <field>Status</field>
        <literalValue>Awaiting Standard Discount</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PCStatustoDiscount Review</fullName>
        <field>Status</field>
        <literalValue>Discount Review</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PCStatustoDisti Manager Approval</fullName>
        <field>Status</field>
        <literalValue>Disti Manager Approval</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ReadyForL2ApproverFalse</fullName>
        <field>ReadyForL2Approver__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Rejected</fullName>
        <field>Status</field>
        <literalValue>Rejected</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submit for ASL</fullName>
        <field>Status</field>
        <literalValue>Submit for ASL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submit for Final RDD</fullName>
        <field>Status</field>
        <literalValue>Submit for  Final RDD</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submit for RDD</fullName>
        <field>Status</field>
        <literalValue>Submit for RDD</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Submit for RFL and RGM</fullName>
        <field>Status</field>
        <literalValue>Submit for RFL AND RGM</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdStatus</fullName>
        <field>Status</field>
        <literalValue>Awaiting Approval</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_Approval_Sub_Date</fullName>
        <field>Approval_Submission_Date__c</field>
        <formula>TODAY()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_IsAftermarketServicesToFalse</fullName>
        <field>IsAftermarketServicesPdtLineExists__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_IsApproved</fullName>
        <field>IsApproved__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_IsBarcodePdtLineExistsToFalse</fullName>
        <field>IsBarcodePdtLineExists__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_IsCardPdtLineExistsToFalse</fullName>
        <field>IsCardPdtLineExists__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_ResetPdtMgrApprovalField</fullName>
        <field>ResetPdtMgrApproval__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Mgr Lookup</fullName>
        <field>Update_Manager_Lookup__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Mgr Lookup False</fullName>
        <field>Update_Manager_Lookup__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update PCStatus_Approved</fullName>
        <field>Status</field>
        <literalValue>Approved</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Status to In Process</fullName>
        <field>Status</field>
        <literalValue>In Process</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdatePCEnableFlagtoTrue</fullName>
        <field>PC_Enable_Flag__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UpdatePriceAllFlagtoFalse</fullName>
        <field>PC_PriceAll__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_isReadyForApprovalToFalse</fullName>
        <field>isReadyForApproval__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Email to Distributor%27s Owner</fullName>
        <field>Account_Owner_Email__c</field>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Email to Reseller%27s Owner</fullName>
        <field>Account_Owner_Email__c</field>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>isLaProductCategory_ApprovalToFalse</fullName>
        <field>isLaProductCategory_Approval__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>isNaProductCategory_ApprovalToFalse</fullName>
        <field>isNaProductCategory_Approval__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>isNaProductLineApprovalToFalse</fullName>
        <field>isNaProductLine_Approval__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>status Update</fullName>
        <field>Status</field>
        <literalValue>Rejected</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update_isReadyForApprovalToTrue</fullName>
        <field>isReadyForApproval__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Send Email on PC Cancellation to Distributor%27s Owner</fullName>
        <actions>
            <name>ZEB Email Alert To Account Owner on PC Cancellation</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>ZEB Update Email to Distributor%27s Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Quote.Status</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Quote.Direct_Distributor__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Email on PC Cancellation to Opportunity Owner</fullName>
        <actions>
            <name>ZEB Email Alert To Opportunity Owner on PC Cancellation</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Quote.Status</field>
            <operation>equals</operation>
            <value>Awating Approval</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Email on PC Cancellation to Reseller%27s Owner</fullName>
        <actions>
            <name>ZEB Email Alert To Account Owner on PC Cancellation</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>ZEB Update Email to Reseller%27s Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Quote.Status</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Quote.Direct_Reseller__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Email on PC Expiration to Distributor Owner</fullName>
        <actions>
            <name>ZEB Email Alert To Account Owner on PC Expiration</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>ZEB Update Email to Distributor%27s Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Quote.Status</field>
            <operation>equals</operation>
            <value>Expired</value>
        </criteriaItems>
        <criteriaItems>
            <field>Quote.Direct_Distributor__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Email on PC Expiration to Reseller Owner</fullName>
        <actions>
            <name>ZEB Email Alert To Account Owner on PC Expiration</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>ZEB Update Email to Reseller%27s Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Quote.Status</field>
            <operation>equals</operation>
            <value>Expired</value>
        </criteriaItems>
        <criteriaItems>
            <field>Quote.Direct_Reseller__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
