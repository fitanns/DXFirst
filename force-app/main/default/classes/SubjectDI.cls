/**
 * Created by DmytroPinchuk on 09.10.2019.
 */

public with sharing class SubjectDI {
    public Subject__c getSubjectInformation(String subjectName) {
        DependencyInjector.overrideByStatic(SubjectInterface.class, SubjectInfoService.class);
        SubjectInterface subjectInterface = (SubjectInterface) DependencyInjector.getInstance(SubjectInterface.class);
        List<Subject__c> subject = subjectInterface.getSubjectInfo(subjectName);
        if (subject.size() > 0) {
            return subject[0];
        } else {
            throw new SubjectNotExistException('This subject does not exist. Please try to find another.');
        }
    }
    public class SubjectNotExistException extends Exception {
    }
}