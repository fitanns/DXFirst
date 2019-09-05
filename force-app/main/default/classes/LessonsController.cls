/**
 * Created by DmytroPinchuk on 21.08.2019.
 */

global with sharing class LessonsController {

    @AuraEnabled
    global static Map<String, String> getLessonsTimes(String ourDate) {
        Date newDate = Date.valueOf(ourDate);
        List<Lesson__c> lessons = [SELECT Id,Name, Date__c, Time__c,Course__r.Name FROM Lesson__c WHERE Date__c = :newDate];
        Map<String, String> courseAndLessonTime = new Map<String, String>();
        List<String> times = new List<String>();
        for (Lesson__c lesson : lessons) {
            Time ourTime = lesson.Time__c;
            Integer ourMinutes = ourTime.minute();
            String minutes ;
            if(ourMinutes < 10){
                minutes = '0' + ourMinutes;
            } else {
                minutes = ourMinutes.format();
            }
            String timeString = ourTime.hour() + ':' + minutes;
            courseAndLessonTime.put((String) lesson.Course__r.Name, timeString);
            times.add(timeString);
        }
        return courseAndLessonTime;
    }
}