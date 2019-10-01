/**
 * Created by DmytroPinchuk on 24.09.2019.
 */

public with sharing class LeadApprovalHandler {

    public void checkApprovalStatus(List<SObject> newItems, Map<Id, SObject> oldItems) {
        List<Lead> leads = (List<Lead>) newItems;
        Map<Id, Lead> oldLeads = (Map<Id, Lead>) oldItems;
        List<Lead> approvedLeads = new List<Lead>();

        for (Lead lead : leads) {
            Lead oldLead = oldLeads.get(lead.Id);
            if (lead.ApprovalStatus__c != oldLead.ApprovalStatus__c && lead.ApprovalStatus__c == 'Approved') {
                approvedLeads.add(lead);
            }
        }
        if (approvedLeads.size() > 0) {
            LeadService service = new LeadService();
            service.covertLeadToOppContact(approvedLeads);
        }
    }
}