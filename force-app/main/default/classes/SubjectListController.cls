/**
 * Created by DmytroPinchuk on 17.09.2019.
 */

public with sharing class SubjectListController {

    @AuraEnabled
    public static List<Subject__c> getSubjects(){
        SubjectSelector subjectSelector = new SubjectSelector();
        List<Subject__c> subjects = subjectSelector.selectSubject();
        return subjects;
    }
}