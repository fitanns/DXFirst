/**
 * Created by DmytroPinchuk on 21.08.2019.
 */

@IsTest
private class ListUtilityTest {

    @isTest static void testUtility() {
        List<Subject__c> subjects = TestDataFactory.insertSubjects(2);
        List<Id> subjectIds = ListUtility.getIds(Subject__c.Id, subjects);
        System.assertEquals(2, subjectIds.size());
    }
}