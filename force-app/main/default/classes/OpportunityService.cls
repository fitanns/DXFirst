/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

public with sharing class OpportunityService {
    public void sendSmsToClient(List<sObject> newItems) {
        List<Opportunity> opportunities = (List<Opportunity>) newItems;
        Set<Id> accountsIds = SetUtility.getIds(Opportunity.AccountId, opportunities);
        ContactSelector contactSelector = new ContactSelector();
        List<Contact> contacts = contactSelector.getContactByAccountId(accountsIds);
        for(Contact contact : contacts){
            SendSmsService smsService = new SendSmsService();
            smsService.verifiedPhone(contact.MobilePhone);
            //
        }
    }
}