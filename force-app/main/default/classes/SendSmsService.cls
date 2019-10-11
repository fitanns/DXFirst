/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

public with sharing class SendSmsService {
    public void verifiedPhone(String phoneNumber, String fromPhone, String accountSID, String token) {
        /*      Map<String, String> params = new Map<String, String>{
                      'friendlyName' => 'TestPhone',
                      'phoneNumber' => '+380637323742'
              };*/
        TwilioRestClient client = new TwilioRestClient(accountSID, token);
        TwilioOutgoingCallerIdList idList = new TwilioOutgoingCallerIdList(client);
        idList.setRequestAccountSid(accountSID);
        TwilioCallerIdValidation idValidation = idList.validate(phoneNumber);
        /*     System.debug(idValidation);
             System.debug(idValidation.getValidationCode());
             System.debug(idValidation.getPhoneNumber());
             System.debug(idValidation.getFriendlyName());*/
        SendSmsService smsService = new SendSmsService();
        smsService.sendSms(phoneNumber, fromPhone, accountSID, token);

    }
    public SMS_Log__c sendSms(String phoneNumber, String fromPhone, String accountSID, String token) {
        TwilioRestClient client = new TwilioRestClient(accountSID, token);
        Map<String, String> params = new Map<String, String>{
                'To' => phoneNumber,
                'From' => fromPhone,
                'Body' => 'Your request to course was successfully accepted! Our manager contact you as soon as possible. Course Managment Team.'
        };
        TwilioSMS twilioSMS = client.getAccount().getSMSMessages().create(params);
        return new SMS_Log__c(Status__c = twilioSMS.getStatus(),To__c = twilioSMS.getTo(),From__c = twilioSMS.getFrom());

    }
}