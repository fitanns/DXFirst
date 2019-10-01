/**
 * Created by DmytroPinchuk on 16.09.2019.
 */

public with sharing class LeadService {

    public void createSingle(Lead lead) {
        create(new List<Lead>{
                lead
        });
    }

    public void create(List<Lead> leads) {
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
                new Schema.SObjectType[]{
                        leads[0].getSObjectType()
                });
        for (Lead lead : leads) {
            lead.Status = 'Open - Not Contacted';
            uow.registerNew(lead);
        }
        uow.commitWork();
    }
    public void checkApprovalStatus(List<SObject> newItems, Map<Id, SObject> oldItems) {
        LeadApprovalHandler leadApprovalHandler = new LeadApprovalHandler();
        leadApprovalHandler.checkApprovalStatus(newItems, oldItems);
    }

    public void covertLeadToOppContact(List<Lead> approvedLeads) {
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
        List<Database.LeadConvert> convertLeads = new List<Database.LeadConvert>();

        for (Lead lead : approvedLeads) {
            if (lead.isConverted == false) {
                Database.LeadConvert leadConvert = new Database.LeadConvert();
                leadConvert.setLeadId(lead.Id);
                leadConvert.setConvertedStatus(convertStatus.MasterLabel);
                convertLeads.add(leadConvert);
            }
        }
        if (convertLeads.size() > 0) {
            Database.LeadConvertResult[] lcResults = Database.convertLead(convertLeads, false);
            for (Database.LeadConvertResult lcr : lcResults) {
                if (lcr.isSuccess()) {
                } else {
                    System.debug('Error converting new Lead: ' + lcr.getErrors()[0].getMessage());
                }
            }

        }
    }
}