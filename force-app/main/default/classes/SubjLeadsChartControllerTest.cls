/**
 * Created by DmytroPinchuk on 07.10.2019.
 */
@isTest
public with sharing class SubjLeadsChartControllerTest {

    @isTest
    public static void testLeadsBySubject() {
        List<Subject__c> subjects = TestDataFactory.insertSubjects(1);
        List<Lead> leads = TestDataFactory.insertLeads(1, subjects[0]);
        Test.startTest();
        List<SubjLeadsChartController.Data> someData = SubjLeadsChartController.getLeadsBySubject();
        Test.stopTest();
        System.assertEquals(1, someData.size());
    }
    @isTest
    public static void testFormBatchData() {
        List<Subject__c> subjects = TestDataFactory.insertSubjects(1);
        List<Lead> leads = TestDataFactory.insertLeads(1, subjects[0]);
        Test.startTest();
        SubjLeadsChartController.fireBatchToFormData();
        Test.stopTest();
        List<SubjectsLeadsData__c> subjectsLeadsData = SubjLeadsChartController.getSubjectsLeadsData();
        System.assertEquals(1, subjectsLeadsData.size());
    }
}