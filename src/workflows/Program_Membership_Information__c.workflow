<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change Product Access Exp Date blank</fullName>
        <field>Expiration_Date__c</field>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Product Access Status ChangeNot Eligble</fullName>
        <field>Status__c</field>
        <literalValue>Not Eligible</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Member Status as Current member</fullName>
        <field>Member_Status__c</field>
        <literalValue>Current Member</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Member Status to Expired</fullName>
        <field>Member_Status__c</field>
        <literalValue>Expired</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Product Access Status as eligible</fullName>
        <field>Status__c</field>
        <literalValue>Eligible</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>uncheck Updated by Certification Batch</fullName>
        <field>Updated_by_Certification_Batch__c</field>
        <literalValue>0</literalValue>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>CertifiedProduct_Specialization_AccessStatus_MemberStatus_Change</fullName>
        <actions>
            <name>Update Member Status as Current member</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Program_Membership_Information__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Specialization,Certified Product</value>
        </criteriaItems>
        <criteriaItems>
            <field>Program_Membership_Information__c.Status__c</field>
            <operation>equals</operation>
            <value>Waiver,Eligible</value>
        </criteriaItems>
        <description>If Product Access is waiver,update the product access to ‘Not Eligible’ and Member Status to ‘Expired’ on reaching the product access expiration date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>CertifiedProduct_notEligible_MemberstatusChange_ExpdateBlank</fullName>
        <actions>
            <name>Change Product Access Exp Date blank</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Product Access Status ChangeNot Eligble</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Program_Membership_Information__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Certified Product,Program,Specialization</value>
        </criteriaItems>
        <criteriaItems>
            <field>Program_Membership_Information__c.Member_Status__c</field>
            <operation>equals</operation>
            <value>Expired</value>
        </criteriaItems>
        <description>when Product access status of Certified product becomes Not eligible ,set Product Access Expiration Date to blank and Member status as Expired</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Product Access Status to Eligible based on Member Status - Current Member %28Program%29</fullName>
        <actions>
            <name>Update Product Access Status as eligible</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Program_Membership_Information__c.Member_Status__c</field>
            <operation>equals</operation>
            <value>Current Member</value>
        </criteriaItems>
        <criteriaItems>
            <field>Program_Membership_Information__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Program,Specialization</value>
        </criteriaItems>
        <criteriaItems>
            <field>Program_Membership_Information__c.Status__c</field>
            <operation>equals</operation>
            <value>,Not Eligible</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Uncheck the checkbox Updated by Certification Batch</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Program_Membership_Information__c.Updated_by_Certification_Batch__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
