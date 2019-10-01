/**
 * Created by DmytroPinchuk on 26.09.2019.
 */

@IsTest
private class RequestFormControllerTest {
    @IsTest
    static void testRequestLead() {
        List<Lead> leads = TestDataFactory.formPotentialLeads(1);
        Test.startTest();
        RequestFormController.saveRequestLead(leads[0]);
        Test.stopTest();
        Integer lessons = [SELECT COUNT() FROM Lead WHERE FirstName = 'TestName1'];
        System.assertEquals(1, lessons);
    }

    @IsTest
    static void testLeadFields() {
        Test.startTest();
        List<String> leadFields = RequestFormController.getLeadFields();
        Test.stopTest();
        System.assertEquals(leadFields.size() > 0, true);
    }

    @IsTest
    static void testFieldSet() {
        Test.startTest();
        List<FieldSetFields> fields = RequestFormController.getFieldSetField();
        Test.stopTest();
        System.assertEquals(fields.size() > 0, true);

    }
}