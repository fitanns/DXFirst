/**
 * Created by DmytroPinchuk on 11.10.2019.
 */
@isTest
public with sharing class OpportunityServiceTest {
    @isTest
    public static void testSendSmsToClient() {
        TriggerDispatcher.isEnabled = false;
        List<Account> accounts = TestDataFactory.insertAccounts(1);
        List<Contact> contacts = TestDataFactory.insertContacts(1, accounts[0].Id, '+380630249595');
        List<Opportunity> opportunities = TestDataFactory.insertOpportunities(1, accounts[0].Id);
        String authToken = '12345678901234567890123456789012';
        string accountJsonResponseBody = '{'
                + '"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
                + '"api_version": "2008-08-01",'
                + '"body": "Test sending sms from twilio",'
                + '"date_created": "Mon, 7 Oct 2019 10:49:17 +0000",'
                + '"date_sent": "Mon, 7 Oct 2019 10:49:17 +0000",'
                + '"date_updated": "Mon, 7 Oct 2019 10:49:17 +0000",'
                + '"direction": "outbound-api",'
                + '"from": "+12563635238",'
                + '"price": "-0.02000",'
                + '"sid": "SM800f449d0399ed014aae2bcc0cc2f2ec",'
                + '"status": "queued",'
                + '"to": "+380630249595",'
                + '"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/SMS/Messages/SM800f449d0399ed014aae2bcc0cc2f2ec.json"'
                + '}';
        Twilio_TestHTTPMock.getInstance().putResponse(
                'POST',
                'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/SMS/Messages.json',
                new Twilio_TestHTTPMock.Response(accountJsonResponseBody, 200)
        );
        Test.startTest();
        OpportunityService opportunityService = new OpportunityService();
        opportunityService.sendSmsToClient((List<SObject>) opportunities, '+12563635238',
                'AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
        Test.stopTest();
        List<SMS_Log__c> smsLogs = [SELECT Id,Status__c,From__c,To__c FROM SMS_Log__c];
        System.assertEquals('queued', smsLogs[0].Status__c);
        System.assertEquals('+380630249595', smsLogs[0].To__c);
        System.assertEquals('+12563635238', smsLogs[0].From__c);

    }
}