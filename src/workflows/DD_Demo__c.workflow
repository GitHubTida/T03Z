<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Demo Request Approved by Manager %28Notification to AM%2CSE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Approved_by_Manager</template>
    </alerts>
    <alerts>
        <fullName>Demo Request Approved by Program Admin %28Notification to Manager%2CSE%2CAM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Approved_by_Program_Admin</template>
    </alerts>
    <alerts>
        <fullName>Demo Request Approved by SE %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Approved_by_SE</template>
    </alerts>
    <alerts>
        <fullName>Demo Request Rejected by Manager %28Notification to AM%2CSE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Rejected_by_Manager</template>
    </alerts>
    <alerts>
        <fullName>Demo Request Rejected by Program Admin %28Notification to SE%2CManager%2CAM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Rejected_by_Program_Admin</template>
    </alerts>
    <alerts>
        <fullName>Demo Request Rejected by SE %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Rejected_by_SE</template>
    </alerts>
    <alerts>
        <fullName>Email Alert to AM On Request Submission</fullName>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Confirmation_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 1 day of Return By %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 1 day of Return By %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 1 day of Return By %28Notification to Financial Controller%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Financial_Controller__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Financial_Controller</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 1 day of Return By %28Notification to Manager%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Manager</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 1 day of Return By %28Notification to Manager%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Manager</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 1 day of Return By %28Notification to SE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_SE</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 1 day of Return By %28Notification to SE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_SE</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 10 days of Return By %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 10 days of Return By %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 10 days of Return By %28Notification to Manager%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Manager</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 10 days of Return By %28Notification to Manager%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Manager</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 10 days of Return By %28Notification to SE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_SE</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 10 days of Return By %28Notification to SE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_SE</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 3 days of Return By %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 3 days of Return By %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 3 days of Return By %28Notification to Manager%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Manager</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 3 days of Return By %28Notification to Manager%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Manager</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 3 days of Return By %28Notification to SE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_SE</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 3 days of Return By %28Notification to SE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_SE</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 5 days of Return By %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 5 days of Return By %28Notification to AM%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Account_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_AM</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 5 days of Return By %28Notification to Manager%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Manager</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 5 days of Return By %28Notification to Manager%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_Manager</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 5 days of Return By %28Notification to SE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_SE</template>
    </alerts>
    <alerts>
        <fullName>Return Reminder Email Alert before 5 days of Return By %28Notification to SE%29</fullName>
        <protected>false</protected>
        <recipients>
            <field>System_Engineer__c</field>
            <type>userLookup</type>
        </recipients>
        <template>Demo_Depot_Email_Template/DD_Demo_Request_Due_for_Return_Notification_to_SE</template>
    </alerts>
    <fieldUpdates>
        <fullName>Accept to False</fullName>
        <field>Accept__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Accept to True</fullName>
        <field>Accept__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Demo Request External Id</fullName>
        <field>External_Id__c</field>
        <formula>Name</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset Approval Status</fullName>
        <field>Approval_Status__c</field>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status Update Admin Approval</fullName>
        <field>Demo_Status__c</field>
        <literalValue>Awaiting Admin Approval</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status Update Manager Approval</fullName>
        <field>Demo_Status__c</field>
        <literalValue>Awaiting Manager Approval</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status Update Not Submitted</fullName>
        <field>Demo_Status__c</field>
        <literalValue>Awaiting AM Submission</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status Update SE Validation</fullName>
        <description>Update the demo status to Awaiting SE validation</description>
        <field>Demo_Status__c</field>
        <literalValue>Awaiting SE Validation</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status Update To Shipment</fullName>
        <field>Demo_Status__c</field>
        <literalValue>Awaiting Service Action</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Approved Date</fullName>
        <field>DD_Demo_Approved_Date__c</field>
        <formula>Now()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Approved Date</fullName>
        <field>DD_Demo_Approved_Date__c</field>
        <formula>Now()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Closed Date</fullName>
        <field>Closed_Date__c</field>
        <formula>Today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Delete Reserved Product status</fullName>
        <field>DeleteReservedProducts__c</field>
        <literalValue>True</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Delete parts reserved</fullName>
        <field>Delete_Parts_On_Reject__c</field>
        <literalValue>True</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updated Approval Status Rejected</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Rejected</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updated Approval status</fullName>
        <field>Approval_Status__c</field>
        <literalValue>Approved</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update status delete product false</fullName>
        <field>DeleteReservedProducts__c</field>
        <literalValue>False</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>update status delete product true</fullName>
        <field>DeleteReservedProducts__c</field>
        <literalValue>True</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Demo Closed Date Population</fullName>
        <actions>
            <name>Update Closed Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Demo_Status__c), OR( ISPICKVAL(Demo_Status__c, &quot;Closed&quot;), ISPICKVAL(Demo_Status__c, &quot;Closed With Missing Product&quot;), ISPICKVAL(Demo_Status__c, &quot;Return In Progress&quot;) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Demo Request - External Id</fullName>
        <actions>
            <name>Demo Request External Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>DD_Demo__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Demo Return Reminder Workflow for AM%2CSE and Manager</fullName>
        <active>true</active>
        <description>workflow to send the reminder notification to the AM,SE and Manager</description>
        <formula>AND( TEXT(Demo_Status__c) = &apos;Shipped&apos;, TEXT(Account_Manager__r.Theater__c) !=&apos;NA&apos; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Demo Return Reminder Workflow for AM%2CSE%2CManager and Financial Controller %28For NA region only%29</fullName>
        <active>true</active>
        <description>workflow to send the reminder notification to the AM,SE,Manager and Financial Controller for NA region only</description>
        <formula>AND( TEXT(Demo_Status__c) = &apos;Shipped&apos;, TEXT(Account_Manager__r.Theater__c) =&apos;NA&apos; )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
