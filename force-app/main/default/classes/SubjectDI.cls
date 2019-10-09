/**
 * Created by DmytroPinchuk on 09.10.2019.
 */

public with sharing class SubjectDI {
    public List<Subject__c> mathInfo() {
        SubjectInfoFactory factory = new SubjectInfoFactory();
        SubjectInterface mathInterface = factory.getMathInfo();
        return mathInterface.getSubjectInfo();
    }
    public List<Subject__c> phizInfo() {
        SubjectInfoFactory factory = new SubjectInfoFactory();
        SubjectInterface phizInterface = factory.getPhizInfo();
        return phizInterface.getSubjectInfo();
    }
}