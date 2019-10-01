/**
 * Created by DmytroPinchuk on 19.09.2019.
 */

@IsTest
private class LeadServiceTest {
    @IsTest
    static void testInsertSingleLead() {
        LeadService leadService = new LeadService();
        Test.startTest();
        leadService.createSingle(TestDataFactory.formPotentialLeads(1)[0]);
        Test.stopTest();
        Integer countsLeads = [SELECT Count() FROM Lead WHERE FirstName = 'TestName1'];
        System.assertEquals(1, countsLeads);
    }
    @isTest
    static void testInsertBulkifyLeads() {
        LeadService leadService = new LeadService();
        Test.startTest();
        leadService.create(TestDataFactory.formPotentialLeads(5));
        Test.stopTest();
        Integer countsLeads = [SELECT Count() FROM Lead WHERE FirstName LIKE 'TestName%'];
        System.assertEquals(5, countsLeads);
    }
    @isTest
    static void integrationTestApprovedLeads() {
        Test.startTest();
        List<Lead> leads = TestDataFactory.updateToApproval(TestDataFactory.insertLeads(5));
        Test.stopTest();
        List<String> emails = new List<String>();
        for (Lead lead : leads) {
            emails.add(lead.Email);
        }
        Integer contacts = [SELECT Count() FROM Contact WHERE Email IN :emails];
        System.assertEquals(5, contacts);
    }

/*    @isTest
    static void unitTestApprovedLeads() {
        TriggerDispatcher.isEnabled = false;
        List<Lead> oldLeads = TestDataFactory.insertLeads(5);
        List<Lead> updatedLeads = TestDataFactory.updateToApproval(oldLeads);
        Map<Id, SObject> mapOldLeadsByIds = MapUtility.groupRecordToMapByIds(Lead.Id, oldLeads, Map<Id, Lead>.class, Lead.class);
        System.debug(mapOldLeadsByIds);
        LeadService leadService = new LeadService();
        Test.startTest();
            leadService.checkApprovalStatus((List<SObject>)updatedLeads,mapOldLeadsByIds);
        Test.stopTest();
        List<String> emails = new List<String>();
        for (Lead lead : updatedLeads) {
            emails.add(lead.Email);
        }
        Integer contacts = [SELECT Count() FROM Contact WHERE Email IN :emails];
        System.assertEquals(5, contacts);
    }*/

/*    @isTest
    static void integrationTestRejectedLeads() {
        TestDataFactory.updateToRejected(TestDataFactory.insertLeads(5));
        Integer emailsLimits = Limits.getEmailInvocations();
        System.assertEquals(2, emailsLimits);
    }*/
/*    @isTest
    static void unitTestApprovedLeads() {
        TriggerDispatcher.isEnabled = false;
        List<Lead> leads = TestDataFactory.insertLeads(5);
        List<Lead> newLeads = TestDataFactory.updateToRejected(leads);
        Map<Id, Lead> mapOldLeadsByIds = (Map<Id,Lead>)MapUtility.groupRecordToMapByIds(Lead.Id, leads, Map<Id, Lead>.class, Lead.class);
        LeadService leadService = new LeadService();
        leadService.checkApprovalStatus(newLeads, mapOldLeadsByIds);
        Integer emailsLimits = Limits.getEmailInvocations();
        System.assertEquals(2, emailsLimits);
    }*/
}