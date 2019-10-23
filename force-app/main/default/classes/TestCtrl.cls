/**
 * Created by DmytroPinchuk on 11.09.2019.
 */

public with sharing class TestCtrl {
    @AuraEnabled
    public static List<ContentVersion> getContents(String course) {
        Course__c selectedCourse = (Course__c) JSON.deserialize(course, Course__c.class);
        Set<Id> cdIds = new Set<Id>();
        List<ContentDocumentLink> contentDocumentLinks = [
                SELECT ContentDocumentId,ContentDocument.Title
                FROM ContentDocumentLink
                WHERE LinkedEntityId =: selectedCourse.Id
        ];
        for(ContentDocumentLink link : contentDocumentLinks){
           cdIds.add(link.ContentDocumentId);
        }

        List<ContentVersion> cv = [SELECT Id,Title From ContentVersion WHERE ContentDocumentId IN : cdIds];
        return cv;
    }
}