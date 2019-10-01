/**
 * Created by DmytroPinchuk on 18.09.2019.
 */

public with sharing class SendEmailService {

    public void sendLeadTemplateEmailMessage(List<SObject> sobjectsLeads, String emailTemplateName) {
        List<Lead> newLeads = (List<Lead>) sobjectsLeads;
        EmailTemplate emailTemplate = [SELECT Id FROM EmailTemplate WHERE Name = :emailTemplateName];
        List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();

        for (Lead lead : newLeads) {
            Messaging.SingleEmailMessage singleEmailMessages = new Messaging.SingleEmailMessage();
            singleEmailMessages.setTargetObjectId(lead.Id);
            singleEmailMessages.toAddresses = new String[]{
                    lead.Email
            };
            singleEmailMessages.setTemplateId(emailTemplate.Id);
            messages.add(singleEmailMessages);
        }

        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        if (results[0].success) {
            System.debug('The email was sent successfully.');
        } else {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
    }
}