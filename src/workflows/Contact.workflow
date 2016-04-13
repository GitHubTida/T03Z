<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>SSO Partner Admin Upgrade APAC</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>SSO_Templates/SSO_Partner_Admin_Upgrade_NA_LATAM_APAC</template>
    </alerts>
    <alerts>
        <fullName>SSO Partner Admin Upgrade EMEA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>SSO_Templates/SSO_Partner_Admin_Upgrade_EMEA</template>
    </alerts>
    <alerts>
        <fullName>SSO Partner Admin Upgrade LATAM</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>SSO_Templates/SSO_Partner_Admin_Upgrade_NA_LATAM_APAC</template>
    </alerts>
    <alerts>
        <fullName>SSO Partner Admin Upgrade NA</fullName>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <template>SSO_Templates/SSO_Partner_Admin_Upgrade_NA_LATAM_APAC</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change Restricted Contact</fullName>
        <description>This field will update everytime the change_restricted_c field is marked as true.</description>
        <field>Change_Restricted_contact__c</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact - Update Email Opt Out Custom</fullName>
        <field>Custom_Email_Opt_Out__c</field>
        <literalValue>Yes</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact - Update Email Opt Out Custom2</fullName>
        <field>Custom_Email_Opt_Out__c</field>
        <literalValue>No</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact - Update Email Opt Out Standard</fullName>
        <field>HasOptedOutOfEmail</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact - Update Email Opt Out Standard2</fullName>
        <field>HasOptedOutOfEmail</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact - Update Phone Opt Out Custom</fullName>
        <field>Custom_Call_Opt_Out__c</field>
        <literalValue>Yes</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact - Update Phone Opt Out Custom2</fullName>
        <field>Custom_Call_Opt_Out__c</field>
        <literalValue>No</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact - Update Phone Opt Out Standard</fullName>
        <field>DoNotCall</field>
        <literalValue>1</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact - Update Phone Opt Out Standard2</fullName>
        <field>DoNotCall</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>updatecountry</fullName>
        <field>MailingCountry</field>
        <formula>Account.BillingCountry</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Contact - Custom Email Opt Out</fullName>
        <actions>
            <name>Contact - Update Email Opt Out Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Custom_Email_Opt_Out__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>This workflow will mark the Standard Field Email Opt Out(HasOptedOutOfEmail) as TRUEwhen the Custom Field is changed to YES</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contact - Custom Email Opt Out 2</fullName>
        <actions>
            <name>Contact - Update Email Opt Out Standard2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Custom_Email_Opt_Out__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>This workflow will mark the Standard Field Email Opt Out(HasOptedOutOfEmail) as  FALSE when the Custom Field is changed to NO</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contact - Custom Phone Opt Out</fullName>
        <actions>
            <name>Contact - Update Phone Opt Out Standard</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Custom_Call_Opt_Out__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>This workflow will mark the Standard Field Do Not Call(DoNotCall) as TRUEwhen the Custom Field is changed to YES</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contact - Custom Phone Opt Out 2</fullName>
        <actions>
            <name>Contact - Update Phone Opt Out Standard2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Custom_Call_Opt_Out__c</field>
            <operation>equals</operation>
            <value>No</value>
        </criteriaItems>
        <description>This workflow will mark the Standard Field Do Not Call(DoNotCall) as FALSE when the Custom Field is changed to NO</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contact - Std Email Opt Out</fullName>
        <actions>
            <name>Contact - Update Email Opt Out Custom</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.HasOptedOutOfEmail</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will mark the Custom Field Email Opt Out(Custom_Email_Opt_Out__c) as YES when the standard Field is changed to TRUE</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contact - Std Email Opt Out 2</fullName>
        <actions>
            <name>Contact - Update Email Opt Out Custom2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.HasOptedOutOfEmail</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>This workflow will mark the Custom Field Email Opt Out(Custom_Email_Opt_Out__c) as NO when the standard Field is changed to FALSE</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contact - Std Phone Opt Out</fullName>
        <actions>
            <name>Contact - Update Phone Opt Out Custom</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.DoNotCall</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will mark the Custom Field Call Opt Out (Custom_Call_Opt_Out__c) as YES when the standard Field is changed to TRUE</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contact - Std Phone Opt Out 2</fullName>
        <actions>
            <name>Contact - Update Phone Opt Out Custom2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.DoNotCall</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>This workflow will mark the Custom Field Call Opt Out (Custom_Call_Opt_Out__c) as NO when the standard Field is changed to FALSE</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SSO Partner Admin Upgrade APAC</fullName>
        <actions>
            <name>SSO Partner Admin Upgrade APAC</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Partner</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.User_Created__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Admin_Access_Requested__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Partner_Region__c</field>
            <operation>equals</operation>
            <value>APAC</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>This workflow is created to trigger an email when a Partner Contact is requested to be upgraded to Partner Admin.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SSO Partner Admin Upgrade EMEA</fullName>
        <actions>
            <name>SSO Partner Admin Upgrade EMEA</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Partner</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.User_Created__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Admin_Access_Requested__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Partner_Region__c</field>
            <operation>equals</operation>
            <value>EMEA</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>This workflow is created to trigger an email when a Partner Contact is requested to be upgraded to Partner Admin.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SSO Partner Admin Upgrade LATAM</fullName>
        <actions>
            <name>SSO Partner Admin Upgrade LATAM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Partner</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.User_Created__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Admin_Access_Requested__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Partner_Region__c</field>
            <operation>equals</operation>
            <value>LATAM</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>This workflow is created to trigger an email when a Partner Contact is requested to be upgraded to Partner Admin.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SSO Partner Admin Upgrade NA</fullName>
        <actions>
            <name>SSO Partner Admin Upgrade NA</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Partner</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.User_Created__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Admin_Access_Requested__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Partner_Region__c</field>
            <operation>equals</operation>
            <value>NA</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.Contact_Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>This workflow is created to trigger an email when a Partner Contact is requested to be upgraded to Partner Admin.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
