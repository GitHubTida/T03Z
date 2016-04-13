<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Closing Deal Value %3C 100</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Lead_Templates_SLA_Reqmnt/Closing_Deal_Value_100_New</template>
    </alerts>
    <alerts>
        <fullName>Closing Deal Value %3E 25k</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Lead_Templates_SLA_Reqmnt/Closing_Deal_Value_25K_New</template>
    </alerts>
    <alerts>
        <fullName>Email Notification to Sales Owner and its Inline Manager</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Lead_Templates_SLA_Reqmnt/Update_Leads_Reminder_New</template>
    </alerts>
    <alerts>
        <fullName>Lead - Partner Assigned lead Status is updated</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Lead_Email_Templates/Lead_Partner_Leads_Status_is_updated_New</template>
    </alerts>
    <alerts>
        <fullName>Lead Assigned to Sales</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Lead_Templates_SLA_Reqmnt/leads_assigned_to_Sales_New</template>
    </alerts>
    <alerts>
        <fullName>Lead Partner Contact Assignment</fullName>
        <protected>false</protected>
        <recipients>
            <field>Partner_Contact_Name__c</field>
            <type>contactLookup</type>
        </recipients>
        <template>Lead_Templates_SLA_Reqmnt/Lead_assigned_to_partner_in_Z_SFDC</template>
    </alerts>
    <alerts>
        <fullName>Lead Value not Changed since 3 Days</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Lead_Templates_SLA_Reqmnt/Lead_Value_Not_Updated_for_3_days_New</template>
    </alerts>
    <alerts>
        <fullName>Update Lead Review Date</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>Lead_Templates_SLA_Reqmnt/Update_lead_Review_Date_New</template>
    </alerts>
    <fieldUpdates>
        <fullName>Lead - Cancel Workflow for Closing Deal</fullName>
        <description>Lead - Cancel Workflow for Closing Deal</description>
        <field>Cancel_Workflow__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Closed Lost Date</fullName>
        <description>Lead - Closed Lost Date</description>
        <field>Lead_Closed_lost_Date__c</field>
        <formula>today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Closing Deal Date</fullName>
        <field>Lead_Closing_Deal_Date__c</field>
        <formula>today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Marketing Qualified Date</fullName>
        <field>Lead_Marketing_Qualified_Date__c</field>
        <formula>today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Partner Company Name</fullName>
        <description>Partner Company Name = Blank</description>
        <field>Assign_to_Partner_in__c</field>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Partner Lead Created in MSI</fullName>
        <description>Partner Lead Created in MSI  = False</description>
        <field>Partner_Lead_Created_in_MSI__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Sales Qualified Date</fullName>
        <field>Lead_Sales_Qualified_Date__c</field>
        <formula>today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Update Is Auto MAL</fullName>
        <description>Update &apos;Is Auto MAL&apos; to true</description>
        <field>Is_Auto_MAL__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Update Lead Stage to SAL</fullName>
        <field>Lead_Stage__c</field>
        <literalValue>SAL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Update Lead Stage to SQL</fullName>
        <field>Lead_Stage__c</field>
        <literalValue>SQL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Update the Manager%27s Email</fullName>
        <description>Lead - Update the Manager&apos;s Email</description>
        <field>Manager_s_Email__c</field>
        <formula>Owner:User.Manager1__r.Email</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Update the Partner Assigned field</fullName>
        <description>This workflow action is created for  Updating the Partner Assigned field</description>
        <field>Partner_Assigned_Date__c</field>
        <formula>today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Update the Status for the Partner</fullName>
        <description>Lead - Update the Status for the Partner</description>
        <field>Status</field>
        <literalValue>Assigned</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Update the lead Stage</fullName>
        <description>Update the lead stage to MQL</description>
        <field>Lead_Stage__c</field>
        <literalValue>MQL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead - Update the lead Status</fullName>
        <description>Update the lead status of Assigned on lead record type conversion</description>
        <field>Status</field>
        <literalValue>Assigned</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead Assigned by</fullName>
        <description>Lead Assigned By - A Lead Field - is updated based on the workflow logic.</description>
        <field>Lead_Assigned_By__c</field>
        <formula>LastModifiedBy.FirstName  &amp;  LastModifiedBy.LastName</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead Status Change Date</fullName>
        <description>Capture Lead Status Change Date</description>
        <field>Lead_Status_Change_Date__c</field>
        <formula>TODAY()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lead Value Change Date</fullName>
        <description>This field update is used to capture the date when Lead Value is changed</description>
        <field>Lead_Value_Change_Date__c</field>
        <formula>TODAY()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Leads - Lead Status Change Date</fullName>
        <description>This Field update is created to capture the lead Status change</description>
        <field>Lead_Status_Change_Date__c</field>
        <formula>today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Leads - Update the Lead Record Type SAL</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Sales_Assigned_Lead</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Owner Field Update</fullName>
        <field>OwnerId</field>
        <lookupValue>North Lead Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revert RecordType to EGL</fullName>
        <description>Update RT to EGL on the basis of &apos;Is Auto MAL&apos; flag</description>
        <field>RecordTypeId</field>
        <lookupValue>Eloqua_Generated_Lead</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Revert RecordType to MGL</fullName>
        <description>Update RT to original on the basis of &apos;Is Auto MAL&apos; flag</description>
        <field>RecordTypeId</field>
        <lookupValue>Marketing_Generated_Lead</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Estimated Close Date</fullName>
        <description>Update Estimate Close Date to Todays date if Lead Status is Closing Deal or Closed Lost</description>
        <field>Estimated_Close_Date__c</field>
        <formula>Today()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Lead Stage to Closed Won</fullName>
        <description>Update Lead Stage to Closed Won</description>
        <field>Lead_Stage__c</field>
        <literalValue>Closed Won</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Lead Stage to MAL</fullName>
        <description>Update Lead Stage to MAL</description>
        <field>Lead_Stage__c</field>
        <literalValue>MAL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Lead Stage to MQL</fullName>
        <field>Lead_Stage__c</field>
        <literalValue>MQL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Lead Stage to SAL</fullName>
        <field>Lead_Stage__c</field>
        <literalValue>SAL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Lead Stage to SGL</fullName>
        <description>Updates Lead Stage to SGL</description>
        <field>Lead_Stage__c</field>
        <literalValue>SGL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Lead Stage to SQL</fullName>
        <description>Update Lead Stage to SQL</description>
        <field>Lead_Stage__c</field>
        <literalValue>SQL</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>%5BDO NOT ACTIVATE%5D Lead %28For AnyStatus%29 - Not Updated</fullName>
        <active>false</active>
        <description>This workflow will trigger for aged leads whose status is not being changed for last 40 days</description>
        <formula>AND(Owner:User.Profile.Name &lt;&gt; &apos;Niche Sales&apos;, OR(ISPICKVAL(Status,&apos;New&apos;),ISPICKVAL(Status,&apos;In Progress&apos;),ISPICKVAL(Status,&apos;Callback&apos;), ISPICKVAL(Status,&apos;Closed&apos;), ISPICKVAL(Status,&apos;Marketing Qualified&apos;), ISPICKVAL(Status,&apos;Assigned&apos;), ISPICKVAL(Status,&apos;Accepted&apos;), ISPICKVAL(Status,&apos;Rejected&apos;),  ISPICKVAL(Status,&apos;Sales Qualified&apos;)), !ISBLANK(Lead_Status_Change_Date__c), Cancel_Workflow__c = FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Closing Deal Value %3C 100</fullName>
        <actions>
            <name>Closing Deal Value %3C 100</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This workflow will be fired if Closing Deal Value is less than 100</description>
        <formula>AND(Owner:User.Profile.Name &lt;&gt; &apos;Niche Sales&apos;, ISPICKVAL(Status, &apos;Closing Deal&apos;),   Lead_Value_Lead_Amount__c &lt; 100)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Closing Deal Value %3E 25k</fullName>
        <actions>
            <name>Closing Deal Value %3E 25k</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This WF will be triggered if Lead Amount is greater than 25000</description>
        <formula>AND(Owner:User.Profile.Name &lt;&gt; &apos;Niche Sales&apos;, ISPICKVAL(Status, &apos;Closing Deal&apos;),  Lead_Value_Lead_Amount__c &gt; 25000)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead %28For AnyStatus%29 - Not Updated2</fullName>
        <active>true</active>
        <description>This workflow will trigger for aged leads whose status is not being changed for last 40 days</description>
        <formula>AND(Owner:User.Profile.Name &lt;&gt; &apos;Niche Sales&apos;, OR(ISPICKVAL(Status,&apos;New&apos;),ISPICKVAL(Status,&apos;In Progress&apos;),ISPICKVAL(Status,&apos;Callback&apos;), ISPICKVAL(Status,&apos;Marketing Qualified&apos;), ISPICKVAL(Status,&apos;Assigned&apos;), ISPICKVAL(Status,&apos;Accepted&apos;), ISPICKVAL(Status,&apos;Rejected&apos;),  ISPICKVAL(Status,&apos;Sales Qualified&apos;)), !ISBLANK(Lead_Status_Change_Date__c), Cancel_Workflow__c = FALSE )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Capture the Lead Status Change Date</fullName>
        <actions>
            <name>Leads - Lead Status Change Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow is created to capture the Date on which the lead Status is changed</description>
        <formula>ISCHANGED( Status ) &amp;&amp; NOT( $Setup.RulesDeactivateSwitch__c.Lead_Switch__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Date Closed Lost</fullName>
        <actions>
            <name>Lead - Closed Lost Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update Estimated Close Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Closed Lost</value>
        </criteriaItems>
        <description>This workflow updated the &quot;Closing deal date&quot; when the lead status was changed to &quot;Closing deal&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Date Closing deal</fullName>
        <actions>
            <name>Lead - Closing Deal Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead - Update Lead Stage to SQL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Closing Deal</value>
        </criteriaItems>
        <description>This workflow updated the &quot;Closing deal date&quot; when the lead status was changed to &quot;Closing deal&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Date Marketing Qualified</fullName>
        <actions>
            <name>Lead - Marketing Qualified Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Marketing Qualified</value>
        </criteriaItems>
        <description>This workflow updated the &quot;Marketing Qualified Date&quot; when the lead status was changed to &quot;Marketing Qualified&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Date Sales Qualified</fullName>
        <actions>
            <name>Lead - Sales Qualified Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Sales Qualified</value>
        </criteriaItems>
        <description>This workflow updated the &quot;Sales Qualified Date&quot; when the lead status was changed to &quot;Sales Qualified&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Partner Assigned Date</fullName>
        <actions>
            <name>Lead - Update the Partner Assigned field</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead - Update the Status for the Partner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow is created to capture the Date when the Partner is assigned in Salesforce</description>
        <formula>!ISPICKVAL(Assign_to_Partner_in__c , &apos;&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Populate Estimated Close Date based on Status</fullName>
        <actions>
            <name>Update Estimated Close Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Closed Lost,Closing Deal</value>
        </criteriaItems>
        <description>This workflow defaults the Estimate Close Date to Todays date i.e. the date when the status is changed</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Revert RecordType from SAL to EGL</fullName>
        <actions>
            <name>Revert RecordType to EGL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow updates SAL back to original RecordType when Lead Status is changed to Rejected</description>
        <formula>AND(RecordType.DeveloperName = &apos;Sales_Assigned_Lead&apos;, ISPICKVAL(Status, &apos;Rejected&apos;), Is_Auto_MAL__c = FALSE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Revert RecordType from SAL to MGL</fullName>
        <actions>
            <name>Revert RecordType to MGL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow updates SAL back to original RecordType when Lead Status is changed to Rejected</description>
        <formula>AND(RecordType.DeveloperName = &apos;Sales_Assigned_Lead&apos;, ISPICKVAL(Status, &apos;Rejected&apos;),  Is_Auto_MAL__c = TRUE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Update Lead Stage based on Lead Status %28Accepted%29</fullName>
        <actions>
            <name>Update Lead Stage to SAL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Accepted</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Alias</field>
            <operation>notEqual</operation>
            <value>emark</value>
        </criteriaItems>
        <description>This workflow will update Lead Stage to MAL when Lead Status is Accepted</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Update Lead Stage based on Lead Status %28Assigned%29</fullName>
        <actions>
            <name>Update Lead Stage to SGL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will update Lead Stage to SGL when Lead Status is Assigned for Sales Generated Leads</description>
        <formula>($User.Alias &lt;&gt; &apos;zzebi&apos;)&amp;&amp; ($User.Alias &lt;&gt; &apos;emark&apos;)&amp;&amp;(RecordType.DeveloperName = &apos;Sales_Generated_Lead&apos;) &amp;&amp; (ISPICKVAL(Status, &apos;Assigned&apos;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Update Lead Stage based on Lead Status %28Converted%29</fullName>
        <actions>
            <name>Update Lead Stage to Closed Won</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Converted</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Alias</field>
            <operation>notEqual</operation>
            <value>emark</value>
        </criteriaItems>
        <description>This workflow will update Lead Stage to SQL when Lead Status is Converted</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Update Lead Stage based on Lead Status %28Marketing Qualified%2C Assigned%29</fullName>
        <actions>
            <name>Update Lead Stage to MQL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will update Lead Stage to MAL when Lead Status is Marketing Qualified and Assigned for Marketing and Eloqua Record Types</description>
        <formula>($User.Alias &lt;&gt; &apos;zzebi&apos;)&amp;&amp; ($User.Alias &lt;&gt; &apos;emark&apos;)&amp;&amp;(((RecordType.DeveloperName = &apos;Marketing_Generated_Lead&apos; || RecordType.DeveloperName = &apos;Eloqua_Generated_Lead&apos;) &amp;&amp;  ( ISPICKVAL(Status, &apos;Marketing Qualified&apos;) ||   ISPICKVAL(Status, &apos;Assigned&apos;)    )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Update Lead Stage based on Lead Status %28New%2C Callback%2C In Progress%2C Closed%29</fullName>
        <actions>
            <name>Update Lead Stage to MAL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>New,Callback,In Progress,Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Alias</field>
            <operation>notEqual</operation>
            <value>emark</value>
        </criteriaItems>
        <description>This workflow will update Lead Stage to MAL when Lead Status is New, Callback, In Progress, Closed.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Update Lead Stage based on Lead Status %28Sales Qualified%2C Closed Lost%2C Closing Deal%29</fullName>
        <actions>
            <name>Update Lead Stage to SQL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.Status</field>
            <operation>equals</operation>
            <value>Sales Qualified,Closed Lost,Closing Deal</value>
        </criteriaItems>
        <criteriaItems>
            <field>User.Alias</field>
            <operation>notEqual</operation>
            <value>emark</value>
        </criteriaItems>
        <description>This workflow will update Lead Stage to SQL when Lead Status is Sales Qualified, Closed Lost and Closing Deal</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead - Update Manager Email2</fullName>
        <actions>
            <name>Lead - Update the Manager%27s Email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This Workflow is created for capturing the Owner&apos;s Email Address - This Workflow action will be used to send email notification to the Managers</description>
        <formula>(ISNEW() ||   ISCHANGED( OwnerId ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Owner is Changed</fullName>
        <actions>
            <name>Lead Assigned by</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow will be triggered when Lead Owner is changed</description>
        <formula>ISCHANGED( OwnerId )&amp;&amp;  NOT( $Setup.RulesDeactivateSwitch__c.Lead_Switch__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Review date update Notification to Z seller</fullName>
        <active>true</active>
        <description>If a lead is in Accepted or Sales Qualified status, at 40 days ,the Zebra sales owner  will receive a notification from Z-SFDC to update the lead.</description>
        <formula>AND(Owner:User.Profile.Name &lt;&gt; &apos;Niche Sales&apos;, OR(ISPICKVAL(Status,&apos;Accepted&apos;), ISPICKVAL(Status,&apos;Sales Qualified&apos;)), Cancel_Workflow__c = FALSE)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead Status is Assigned</fullName>
        <actions>
            <name>Lead Assigned to Sales</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>When Lead Is Assigned</description>
        <formula>(Owner:User.Profile.Name = &apos;Sales&apos; ||  Owner:User.Profile.Name = &apos;Sales Management&apos;) &amp;&amp; (ISPICKVAL(Status , &apos;Assigned&apos;)) &amp;&amp; NOT( $Setup.RulesDeactivateSwitch__c.Lead_Switch__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lead Status is Changed for Partner Assigned Leads</fullName>
        <actions>
            <name>Lead - Partner Assigned lead Status is updated</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This workflow wil be triggered for all the Updates on a Partner Assigned Leads</description>
        <formula>!ISPICKVAL( Assign_to_Partner_in__c, &apos;&apos;) &amp;&amp;  ISCHANGED(Status)&amp;&amp;  NOT( $Setup.RulesDeactivateSwitch__c.Lead_Switch__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Value Change Date</fullName>
        <actions>
            <name>Lead Value Change Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This WF will be fired whenver the Lead Value is changed</description>
        <formula>ISCHANGED( Lead_Value_Lead_Amount__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lead Value not Updated</fullName>
        <active>true</active>
        <description>This workflow is used to send notification when Lead Value is not updated within 3 days</description>
        <formula>Owner:User.Profile.Name &lt;&gt; &apos;Niche Sales&apos; &amp;&amp; !OR(ISPICKVAL(Status , &apos;&apos;), ISPICKVAL(Status , &apos;Closing Deal&apos;) , ISPICKVAL(Status , &apos;Closed Lost&apos;),  ISPICKVAL(Status , &apos;Closed&apos;), ISPICKVAL(Status , &apos;Converted&apos;)) &amp;&amp;  !ISBLANK( Lead_Value_Lead_Amount__c ) &amp;&amp; !ISBLANK( Lead_Value_Change_Date__c ) &amp;&amp; Cancel_Workflow__c = FALSE &amp;&amp;  NOT( $Setup.RulesDeactivateSwitch__c.Lead_Switch__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Leads - Change the record type from EGL to Sales Assigned Leads</fullName>
        <actions>
            <name>Lead - Update the lead Stage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead - Update the lead Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Leads - Update the Lead Record Type SAL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This Workflow is created to update the record type of the record to Sales Assigned Leads when the Eloqua Generated Lead is assigned to a SalesProfile User</description>
        <formula>((Owner:User.Profile.Name = &apos;Sales&apos; ||   Owner:User.Profile.Name = &apos;Sales Management&apos;)) &amp;&amp;  RecordType.DeveloperName=&apos;Eloqua_Generated_Lead&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Leads - Change the record type from MGL to Sales Assigned Leads</fullName>
        <actions>
            <name>Lead - Update Is Auto MAL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead - Update Lead Stage to SAL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Lead - Update the lead Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Leads - Update the Lead Record Type SAL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This Workflow is created to update the record type of the record to Sales Assigned Leads when the Marketing Generated Lead is assigned to a SalesProfile User</description>
        <formula>((Owner:User.Profile.Name = &apos;Sales&apos; ||   Owner:User.Profile.Name = &apos;Sales Management&apos;)) &amp;&amp;  RecordType.DeveloperName=&apos;Marketing_Generated_Lead&apos;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Partner Lead Assignment Notification</fullName>
        <actions>
            <name>Lead Partner Contact Assignment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>This Workflow sends notification to Partner when the Lead is Assigned</description>
        <formula>Owner:User.Profile.Name &lt;&gt; &apos;Niche Sales&apos; &amp;&amp; AND((ISPICKVAL( Assign_to_Partner_in__c ,&apos;Z SFDC&apos;)),  NOT(ISBLANK(Partner_Contact_Name__c))) &amp;&amp;  NOT( $Setup.RulesDeactivateSwitch__c.Lead_Switch__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
