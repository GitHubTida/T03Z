<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Close Date Prior Value</fullName>
        <field>CloseDate</field>
        <formula>Priorvalue(CloseDate)</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Opportunity - Update Lead Amount</fullName>
        <description>This workflow field update will populate the standard field &quot;Amount&quot; on Opportunity on leads convert</description>
        <field>Amount</field>
        <formula>Lead_Value_Lead_Amount__c</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update Direct End User Currency</fullName>
        <field>Direct_Account_Currency__c</field>
        <formula>IF(Direct_End_User__c, TEXT(Account.CurrencyIsoCode),  
IF(AND(Direct_Reseller__c, NOT(ISBLANK(TEXT(Opportunity_Reseller__r.CurrencyIsoCode)))),TEXT(Opportunity_Reseller__r.CurrencyIsoCode), 
IF(AND(Direct_Reseller__c, NOT(ISBLANK(TEXT(Primary_Channel_Partner_AIT__r.CurrencyIsoCode)))),TEXT(Primary_Channel_Partner_AIT__r.CurrencyIsoCode),
IF(AND(Direct_Distributor__c, NOT(ISBLANK(TEXT(Opportunity_Distributor__r.CurrencyIsoCode)))),TEXT(Opportunity_Distributor__r.CurrencyIsoCode), 
IF(AND(Direct_Distributor__c, NOT(ISBLANK(TEXT(Primary_Distributor_AIT__r.CurrencyIsoCode)))),TEXT(Primary_Distributor_AIT__r.CurrencyIsoCode),TEXT(CurrencyIsoCode))))))</formula>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Close Date Prior Value</fullName>
        <actions>
            <name>Close Date Prior Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed - Won,Closed - Lost,Closed - Duplicate</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity - Update Lead Amount</fullName>
        <actions>
            <name>Opportunity - Update Lead Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow is created to capture the Lead Amount into the Amount field on Opportunity</description>
        <formula>(  ISNEW()  &amp;&amp; Lead_Value_Lead_Amount__c&gt;0) &amp;&amp; NOT( $Setup.RulesDeactivateSwitch__c.Opportunity_Switch__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Direct Currency</fullName>
        <actions>
            <name>Update Direct End User Currency</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Fulfillment_Type__c</field>
            <operation>contains</operation>
            <value>Direct to End User,Direct to Partner,Distributor Sales Out</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
