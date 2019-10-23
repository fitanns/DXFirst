/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

public with sharing class OpportunityTriggerHandler extends ITriggerHandler {
    public override void AfterInsert(List<sObject> newItems) {
        SmsParams__c smsParams = SmsParams__c.getInstance();
        QueueableSendSms queueableSendSms = new QueueableSendSms(newItems, smsParams.Phone__c, smsParams.AccountSID__c,
                smsParams.Token__c);
        System.enqueueJob(queueableSendSms);
    }
}