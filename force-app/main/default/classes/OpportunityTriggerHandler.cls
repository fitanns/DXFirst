/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

public with sharing class OpportunityTriggerHandler extends ITriggerHandler {
    public override void AfterInsert(List<sObject> newItems) {
        QueueableSendSms queueableSendSms = new QueueableSendSms(newItems, '+12563635238', 'ACb25c8b9090f46594f683cb63b87e5536',
                '0c44f1cca1c88c6100f738ac50fe3c77');
        Id jobId = System.enqueueJob(queueableSendSms);
    }
}