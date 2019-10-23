/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

public with sharing class NotifyUserSmsService {
    public List<SMS_Log__c> sendSmsToClient(List<sObject> newItems, String fromPhone, String accountSID, String token) {
        NotifyUserSmsService notifyUserSmsService = new NotifyUserSmsService();
        List<SMS_Log__c> smsLogs = new List<SMS_Log__c>();
        for (Contact contact : notifyUserSmsService.getContactsForOpportunities(newItems)) {
            SendSmsService sendSmsService = new SendSmsService();
            smsLogs.add(sendSmsService.sendSms(contact.MobilePhone, fromPhone, accountSID, token));
        }
        return smsLogs;
    }
    private List<Contact> getContactsForOpportunities(List<sObject> newItems) {
        List<Opportunity> opportunities = (List<Opportunity>) newItems;
        Set<Id> accountsIds = SetUtility.getIds(Opportunity.AccountId, opportunities);
        ContactSelector contactSelector = new ContactSelector();
        List<Contact> contacts = contactSelector.getContactByAccountId(accountsIds);
        return contacts;
    }
}