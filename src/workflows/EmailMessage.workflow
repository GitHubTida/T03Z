<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ZEB Case Auto Response False</fullName>
        <field>Auto_Responded__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Case First Email Response Date</fullName>
        <field>ZEB_First_Email_Respond_Date__c</field>
        <formula>NOW()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Email Picklist Inbound</fullName>
        <field>Last_Email_Status__c</field>
        <literalValue>Received</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Email Picklist Outbound</fullName>
        <field>Last_Email_Status__c</field>
        <literalValue>Sent</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest In Email Date</fullName>
        <field>ZEB_Latest_Inbound_Email_Date__c</field>
        <formula>MessageDate</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest In Email From</fullName>
        <field>ZEB_Latest_Inbound_Email_From__c</field>
        <formula>FromAddress +&quot; &quot;+&quot;(&quot;+ FromName +&quot;)&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest In Email Subject</fullName>
        <field>ZEB_Latest_Inbound_Email_Subject__c</field>
        <formula>Subject</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest In Email TextBody</fullName>
        <field>ZEB_Latest_Inbound_Email_TextBody__c</field>
        <formula>TextBody</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest In Email To</fullName>
        <field>ZEB_Latest_Inbound_Email_To__c</field>
        <formula>ToAddress</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest Out Email Date</fullName>
        <field>ZEB_Latest_Outbound_Email_Date__c</field>
        <formula>MessageDate</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest Out Email From</fullName>
        <field>ZEB_Latest_Outbound_Email_From__c</field>
        <formula>FromAddress +&quot; &quot;+&quot;(&quot;+ FromName +&quot;)&quot;</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest Out Email Subject</fullName>
        <field>ZEB_Latest_Outbound_Email_Subject__c</field>
        <formula>Subject</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest Out Email To</fullName>
        <field>ZEB_Latest_Outbound_Email_To__c</field>
        <formula>ToAddress</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Case Latest Out Email TxtBody</fullName>
        <field>ZEB_Latest_Outbound_Email_TextBody__c</field>
        <formula>TextBody</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Last Email Received Date-time</fullName>
        <description>This field update will set the Case.ZEB_Last_Email_Received_Date__c to the current system datetime</description>
        <field>ZEB_Last_Email_Received_Date__c</field>
        <formula>NOW()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ZEB Update Last Email Sent Date-time</fullName>
        <description>This field update will set the Case.ZEB_Last_Email_Send_Date__c to the current system datetime</description>
        <field>ZEB_Last_Email_Send_Date__c</field>
        <formula>NOW()</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>ZEB Update Case Email Status Inbound</fullName>
        <actions>
            <name>ZEB Update Case Email Picklist Inbound</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest In Email Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest In Email From</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest In Email Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest In Email TextBody</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest In Email To</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Last Email Received Date-time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.FromAddress</field>
            <operation>notEqual</operation>
            <value>tsnala@zebra.com,tsemea@zebra.com,tsapac@zebra.com,tscn@zebra.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>equals</operation>
            <value>New</value>
        </criteriaItems>
        <description>This workflow will set the Case Email Status to &quot;Received&quot; and Last Email Recieved DateTime whenever a customer responds to a TS question</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ZEB Update Case Email Status Outbound</fullName>
        <actions>
            <name>ZEB Update Case Email Picklist Outbound</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest Out Email Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest Out Email From</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest Out Email Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest Out Email To</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Case Latest Out Email TxtBody</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>ZEB Update Last Email Sent Date-time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>notEqual</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.FromAddress</field>
            <operation>notEqual</operation>
            <value>noreply@salesforce.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This workflow will set the Case Email Status to &quot;Sent&quot; and Last email send date whenever a customer TS sends an email out from a Case</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ZEB Update Case First Email Response</fullName>
        <actions>
            <name>ZEB Case First Email Response Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>notEqual</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.FromAddress</field>
            <operation>notEqual</operation>
            <value>noreply@salesforce.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.ZEB_First_Email_Respond_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Auto_Responded__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>This workflow will update case field first email respond date when first email has been sent from that case.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>ZEB Update Case First Email Response AuotResp</fullName>
        <actions>
            <name>ZEB Case Auto Response False</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>EmailMessage.Status</field>
            <operation>notEqual</operation>
            <value>New</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.FromAddress</field>
            <operation>notEqual</operation>
            <value>noreply@salesforce.com</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.CreatedById</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.ZEB_First_Email_Respond_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Auto_Responded__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>This workflow will update case field first email respond date when first email has been sent from that case.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
