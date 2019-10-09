/**
 * Created by DmytroPinchuk on 09.10.2019.
 */

public with sharing class PhizInfoService implements SubjectInterface {

    public List<Subject__c> getSubjectInfo() {
        SubjectQuerySelector selector = new SubjectQuerySelector();
        List<Subject__c> subjects = selector.getSubjectsByName('Phiz');
        return subjects;
    }
}