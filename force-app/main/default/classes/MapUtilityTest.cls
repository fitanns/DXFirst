/**
 * Created by DmytroPinchuk on 01.09.2019.
 */

@isTest
public with sharing class MapUtilityTest {

    @isTest static void testGroupRecordsByIds() {
        List<Subject__c> subjects = TestDataFactory.insertSubjects(1);
        List<Id> subjectIds = ListUtility.getIds(Subject__c.Id, subjects);
        List<TimeSlot__c> timeSlots = new List<TimeSlot__c>();
        for (Id subId : subjectIds) {
            timeSlots.addAll(TestDataFactory.insertTimeSlots(2, subId));
        }
        Test.startTest();
        Map<Id, List<TimeSlot__c>> timeSlotsBySubjectIds = (Map<Id, List<TimeSlot__c>>)
                MapUtility.groupRecordByIds(TimeSlot__c.Subject__c, timeSlots, Map<Id, List<TimeSlot__c>>.class, List<TimeSlot__c>.class);
        Test.stopTest();

        System.assertEquals(1, timeSlotsBySubjectIds.size());
        System.assertEquals(2, timeSlotsBySubjectIds.get(subjectIds[0]).size());

    }

}