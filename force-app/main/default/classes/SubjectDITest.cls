/**
 * Created by DmytroPinchuk on 09.10.2019.
 */
@isTest
public with sharing class SubjectDITest {
    @isTest
    public static void testMathInfoDI() {
        Subject__c subject = TestDataFactory.insertSingleSubjectsByName(1,'Math');
        SubjectDI subjectDI = new SubjectDI();
        Test.startTest();
        List<Subject__c> subjects = subjectDI.mathInfo();
        Test.stopTest();
        System.assertEquals(1, subjects.size());

    }
    @isTest
    public static void testPhizInfoDI() {
        Subject__c subject = TestDataFactory.insertSingleSubjectsByName(1,'Phiz');
        SubjectDI subjectDI = new SubjectDI();
        Test.startTest();
        List<Subject__c> subjects = subjectDI.phizInfo();
        Test.stopTest();
        System.assertEquals(1, subjects.size());

    }
}