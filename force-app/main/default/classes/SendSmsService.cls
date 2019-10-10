/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

public with sharing class SendSmsService {
    public void verifiedPhone(String phoneNumber) {
        String account = 'ACb25c8b9090f46594f683cb63b87e5536';
        String token = '0c44f1cca1c88c6100f738ac50fe3c77';
  /*      Map<String, String> params = new Map<String, String>{
                'friendlyName' => 'TestPhone',
                'phoneNumber' => '+380637323742'
        };*/

        TwilioRestClient client = new TwilioRestClient(account, token);
        TwilioOutgoingCallerIdList idList = new TwilioOutgoingCallerIdList(client);
        idList.setRequestAccountSid(account);
//        TwilioOutgoingCallerId callerId = (TwilioOutgoingCallerId)idList.makeNew(client, params);
        TwilioCallerIdValidation idValidation =  idList.validate(phoneNumber);
        System.debug(idValidation);
        System.debug(idValidation.getValidationCode());
        System.debug(idValidation.getPhoneNumber());
        System.debug(idValidation.getFriendlyName());
        sendSms(phoneNumber);

    }
    public static void sendSms(String phoneNumber) {
        String account = 'ACb25c8b9090f46594f683cb63b87e5536';
        String token = '0c44f1cca1c88c6100f738ac50fe3c77';
        TwilioRestClient client = new TwilioRestClient(account, token);
        Map<String, String> params = new Map<String, String>{
                'To' => phoneNumber,
                'From' => '+12563635238',
                'Body' => 'Your request to course was successfully accepted! See you at the courses. Course Managment Team'
        };
        TwilioSMS sms = client.getAccount().getSMSMessages().create(params);
    }
}