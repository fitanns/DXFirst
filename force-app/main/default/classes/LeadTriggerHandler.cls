/**
 * Created by DmytroPinchuk on 18.09.2019.
 */

public with sharing class LeadTriggerHandler extends ITriggerHandler {

    public override void AfterInsert(List<sObject> newItems) {
 /*       SendEmailService service = new SendEmailService();
        service.sendLeadTemplateEmailMessage(newItems, 'RegisteredRequest');
        LeadService leadService = new LeadService();*/
//        leadService.submitApprovalRequest(newItems);
    }

    public override void AfterUpdate(List<SObject> newItems, Map<Id, SObject> oldItems) {
        LeadService leadService = new LeadService();
        leadService.checkApprovalStatus(newItems, oldItems);
    }
}