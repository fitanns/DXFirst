/**
 * Created by DmytroPinchuk on 11.10.2019.
 */

public with sharing class QueueableSendSms implements Queueable, Database.AllowsCallouts {
    private List<SObject> newItems;
    private String fromPhone;
    private String accountSID;
    private String token;
    private List<SMS_Log__c> smsLogs = new List<SMS_Log__c>();

    public QueueableSendSms(List<SObject> newItems, String fromPhone, String accountSID, String token) {
        this.newItems = newItems;
        this.fromPhone = fromPhone;
        this.accountSID = accountSID;
        this.token = token;
    }

    public void execute(QueueableContext param1) {
        OpportunityService opportunityService = new OpportunityService();
        smsLogs = opportunityService.sendSmsToClient(newItems, fromPhone, accountSID, token);
        insert smsLogs;
    }
}