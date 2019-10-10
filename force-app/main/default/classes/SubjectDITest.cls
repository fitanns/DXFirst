/**
 * Created by DmytroPinchuk on 09.10.2019.
 */
@isTest
public with sharing class SubjectDITest {
    @isTest
    public static void testGetSubjectInformation() {
        Subject__c testSubject = TestDataFactory.insertSingleSubjectsByName(1, 'Loper');
        Test.startTest();
        SubjectDI subjectDI = new SubjectDI();
        Subject__c subject = subjectDI.getSubjectInformation('Loper');
        Test.stopTest();
        System.assertEquals(subject.Name, testSubject.Name);
    }
    @isTest
    public static void testGetSubjectInformationWithWrongName() {
        Subject__c testSubject = TestDataFactory.insertSingleSubjectsByName(1, 'Run');
        Test.startTest();
        String errMessage;
        try {
            SubjectDI subjectDI = new SubjectDI();
            Subject__c subject = subjectDI.getSubjectInformation('Loper');
        } catch (SubjectDI.SubjectNotExistException e) {
            errMessage = e.getMessage();
        }
        Test.stopTest();
        System.assertEquals('This subject does not exist. Please try to find another.', errMessage);
    }
}