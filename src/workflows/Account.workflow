<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Account Team Email Alert</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>Business Development Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Channel Account Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Inside Channel Account Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Sales Director</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Sales Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <recipients>
            <recipient>Strategic Account Manager</recipient>
            <type>accountTeam</type>
        </recipients>
        <template>All/Account_Team_Email</template>
    </alerts>
    <alerts>
        <fullName>Opportunity Team Email Alert</fullName>
        <protected>false</protected>
        <recipients>
            <recipient>Business Development Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Channel Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Inside Channel Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Sales Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <recipients>
            <recipient>Strategic Account Manager</recipient>
            <type>opportunityTeam</type>
        </recipients>
        <template>All/Opportunity_Team_Email</template>
    </alerts>
    <alerts>
        <fullName>Trigger when AccountNumber has been changed</fullName>
        <ccEmails>nsharma2@zebra.com</ccEmails>
        <protected>false</protected>
        <recipients>
            <recipient>nsharma2@zebra.com.t03sfdc</recipient>
            <type>user</type>
        </recipients>
        <template>All/AccountNumber_Change_Template</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change RT - Financial End User Accounts</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Financial_End_User_Accounts</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change RT - Financial Partners</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Financial_Partners</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change RT-Financial Non-Classified Resel</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Financial_Non_Classified_Resellers</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change Record Type to End User Accounts</fullName>
        <field>RecordTypeId</field>
        <lookupValue>End_User_Accounts</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change Record Type to Non-Classified Res</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Non_Classified_Resellers</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change Record Type to Partners</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Partners</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change Record Type to Prospect</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Prospect</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Check Distributor Flag on Account</fullName>
        <field>Distributor__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck Distributor Flag on Account</fullName>
        <field>Distributor__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Currency</fullName>
        <field>Currency_Code__c</field>
        <formula>TEXT(Owner.Zebra_Currency__c)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Org</fullName>
        <field>Organization__c</field>
        <formula>TEXT(Owner.Zebra_Organization__c)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Change Record Type to End User Accounts</fullName>
        <actions>
            <name>Change Record Type to End User Accounts</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow will change the Account Record Type to End User Accounts  when the Financial Customer flag is set to False.</description>
        <formula>ISPICKVAL(Account_Type__c  , &apos;End User&apos;) &amp;&amp;  NOT(Financial_Customer_Flag__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Financial End User Accounts</fullName>
        <actions>
            <name>Change RT - Financial End User Accounts</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow will change the Account Record Type from End User Accounts to Financial End User Accounts when the Financial Customer flag is set to true.</description>
        <formula>ISPICKVAL(Account_Type__c , &apos;End User&apos;) &amp;&amp; (Financial_Customer_Flag__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Financial Non-Classified Resellers</fullName>
        <actions>
            <name>Change RT-Financial Non-Classified Resel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow will change the Account Record Type from Non-Classified Resellers to Financial Non-Classified Resellers when the Financial Customer flag is set to true.</description>
        <formula>ISPICKVAL(Account_Type__c , &apos;Non Classified Reseller&apos;) &amp;&amp; (Financial_Customer_Flag__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Financial Partners</fullName>
        <actions>
            <name>Change RT - Financial Partners</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow will change the Account Record Type from Partners to Financial Partners when the Financial Customer flag is set to true.</description>
        <formula>ISPICKVAL( Account_Type__c , &apos;Partner&apos;) &amp;&amp; (  Financial_Customer_Flag__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Non-Classified Resellers</fullName>
        <actions>
            <name>Change Record Type to Non-Classified Res</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow will change the Account Record Type to Non-Classified Resellers when the Financial Customer flag is set to false.</description>
        <formula>ISPICKVAL(Account_Type__c , &apos;Non Classified Reseller&apos;) &amp;&amp; NOT(Financial_Customer_Flag__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Partners</fullName>
        <actions>
            <name>Change Record Type to Partners</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow will change the Account Record Type to Partners when the Financial Customer flag is set to false.</description>
        <formula>ISPICKVAL(Account_Type__c , &apos;Partner&apos;) &amp;&amp; NOT(Financial_Customer_Flag__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to Prospect</fullName>
        <actions>
            <name>Change Record Type to Prospect</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>This workflow will change the Account Record Type to Prospects when the Financial Customer flag is set to false.</description>
        <formula>ISPICKVAL(Account_Type__c , &apos;Prospect&apos;) &amp;&amp; NOT(Financial_Customer_Flag__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Distributor Flag on Account</fullName>
        <actions>
            <name>Check Distributor Flag on Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.of_Active_Distributor__c</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>To check the distributor flag on Account based on the program membership information field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck Distributor Flag on Account</fullName>
        <actions>
            <name>Uncheck Distributor Flag on Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.of_Active_Distributor__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <description>To check the distributor flag on Account based on the program membership information field</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Organization</fullName>
        <actions>
            <name>Update Currency</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update Org</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
