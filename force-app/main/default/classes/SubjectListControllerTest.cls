/**
 * Created by DmytroPinchuk on 26.09.2019.
 */
@isTest
public with sharing class SubjectListControllerTest {

    @isTest static void testSubjectSelect(){
        TestDataFactory.insertSubjects(2);
        Test.startTest();
        List<Subject__c> subjects = SubjectListController.getSubjects();
        Test.stopTest();

        System.assertEquals(2,subjects.size());

    }
}