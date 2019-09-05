/**
 * Created by DmytroPinchuk on 21.08.2019.
 */

public with sharing class TestDataFactory {

    public static List<Subject__c> insertSubjects(Integer numberOfSubjects) {
        List<Subject__c> subjects = new List<Subject__c>();
        for (Integer i = 1; i <= numberOfSubjects; i++) {
            subjects.add(new Subject__c(Name = 'SomeSubject' + i, Number_of_Lessons__c = i));
        }
        insert subjects;
        return subjects;
    }

    public static List<TimeSlot__c> insertTimeSlots(Integer numberOfTimeSlots, Id subjectId) {
        List<TimeSlot__c> timeSlots = new List<TimeSlot__c>();
        for (Integer i = 1; i <= numberOfTimeSlots; i++) {
            timeSlots.add(new TimeSlot__c(DayOfWeek__c = 'Monday',
                    Time__c = Time.newInstance(09 + i, 00, 00, 00), Subject__c = subjectId));
        }
        insert timeSlots;
        return timeSlots;
    }

}