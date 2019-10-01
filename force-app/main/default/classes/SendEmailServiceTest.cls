/**
 * Created by DmytroPinchuk on 19.09.2019.
 */

@IsTest
private class SendEmailServiceTest {
    @IsTest
    static void testIntegrationSendEmail() {
        List<Lead> leads = TestDataFactory.insertLeads(2);
        Integer emailsLimits = Limits.getEmailInvocations();
        System.assertEquals(1,emailsLimits);
    }

    @isTest
    static void testSingleSendEmail() {
        TriggerDispatcher.isEnabled = false;
        List<Lead> singleLead = TestDataFactory.insertLeads(1);
        SendEmailService sendEmailService = new SendEmailService();
        sendEmailService.sendLeadTemplateEmailMessage((List<sObject>)singleLead, 'RegisteredRequest');
        Integer emailsLimits = Limits.getEmailInvocations();
        System.assertEquals(1,emailsLimits);
    }

    @isTest
    static void testBulkifySendEmail(){
        TriggerDispatcher.isEnabled = false;
        List<Lead> singleLead = TestDataFactory.insertLeads(5);
        SendEmailService sendEmailService = new SendEmailService();
        sendEmailService.sendLeadTemplateEmailMessage((List<sObject>)singleLead, 'RegisteredRequest');
        Integer emailsLimits = Limits.getEmailInvocations();
        System.assertEquals(1,emailsLimits);
    }
}