/**
 * Created by DmytroPinchuk on 17.09.2019.
 */

public with sharing class SubjectInfoService implements SubjectInterface{

    public List<Subject__c> getSubjectInfo(String subjectName) {
        SubjectQuerySelector selector = new SubjectQuerySelector();
        List<Subject__c> subjects = selector.getSubjectsByName(subjectName);
        return subjects;
    }
}