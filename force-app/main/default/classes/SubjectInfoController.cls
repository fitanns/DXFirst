/**
 * Created by DmytroPinchuk on 17.09.2019.
 */

public with sharing class SubjectInfoController {
    @AuraEnabled
    public static String getUrlsString() {
        String networkString = URL.getSalesforceBaseUrl().toExternalForm();
        return networkString;
    }
    @AuraEnabled(cacheable = true)
    public static List<ContentVersion> getSubjectContents(Subject__c subject) {
        ContentDocumentLinkSelector cdlSelector = new ContentDocumentLinkSelector();
        List<ContentDocumentLink> contentDocumentLinks = cdlSelector.selectBySubjectId(subject.Id);
        Set<Id> cdIds = SetUtility.getIds(ContentDocumentLink.ContentDocumentId, contentDocumentLinks);
        ContentVersionSelector cvSelector = new ContentVersionSelector();
        List<ContentVersion> cv = cvSelector.selectByContentDocumentId(cdIds);
        return cv;
    }

    @AuraEnabled(cacheable = true)
    public static List<Course__c> getSubjectCourses(Subject__c subject) {
        CourseSelector courseSelector = new CourseSelector();
        List<Course__c> courses = courseSelector.selectBySubjectId(subject.Id);
        return courses;
    }
}