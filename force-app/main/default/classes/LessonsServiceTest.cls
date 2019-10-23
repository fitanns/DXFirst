/**
 * Created by DmytroPinchuk on 19.08.2019.
 */

@isTest
public with sharing class LessonsServiceTest {

    @isTest static void testIntegrationCreateLessons() {
        List<Course__c> courses = new List <Course__c>();
        List<Subject__c> subjects = TestDataFactory.insertSubjects(2);
        List<Id> subjectIds = ListUtility.getIds(Subject__c.Id, subjects);
        List<TimeSlot__c> timeSlots = new List<TimeSlot__c>();
        for (Id subId : subjectIds) {
            timeSlots.addAll(TestDataFactory.insertTimeSlots(1, subId));
        }
        for (Integer i = 0; i < subjects.size(); i++) {
            Course__c course = new Course__c();
            course.Name = 'SomeName' + i;
            course.Subject__c = subjects[i].Id;
            Date startDate = Date.today();
            course.Start_Date__c = startDate;
            course.End_Date__c = startDate + 30;
            courses.add(course);
        }

        insert courses;

        Integer lessons = [SELECT COUNT() FROM Lesson__c WHERE Course__r.Name LIKE 'SomeName%'];

        System.assertEquals(3, lessons);

    }

    @isTest static void singleTestLessons() {
        TriggerDispatcher.isEnabled = false;
        List<Subject__c> subject = TestDataFactory.insertSubjects(1);
        List<TimeSlot__c> timeSlots = new List<TimeSlot__c>();
        for (Subject__c sub: subject) {
            timeSlots.addAll(TestDataFactory.insertTimeSlots(1, sub.Id));
        }
        List<Course__c> courses = new List<Course__c>();
        Course__c course = new Course__c();
        course.Name = 'TestCourse';
        course.Subject__c = subject[0].Id;
        Date startDate = Date.today();
        course.Start_Date__c = startDate;
        course.End_Date__c = startDate + 30;
        courses.add(course);

        System.debug('course ' + course);

        insert courses;

        Test.startTest();
        LessonsService createLessons = new LessonsService();
        createLessons.formMap((List<sObject>) courses);
        Test.stopTest();

        Integer lessons = [SELECT Count() FROM Lesson__c WHERE Course__r.Name = 'TestCourse'];

        System.assertEquals(1, lessons);

    }

    @isTest static void bulkifyTestLessons() {
        TriggerDispatcher.isEnabled = false;
        List<Course__c> courses = new List <Course__c>();
        List<Subject__c> subjects = TestDataFactory.insertSubjects(2);
        List<Id> subjectIds = ListUtility.getIds(Subject__c.Id, subjects);
        List<TimeSlot__c> timeSlots = new List<TimeSlot__c>();
        for (Id subId : subjectIds) {
            timeSlots.addAll(TestDataFactory.insertTimeSlots(1, subId));
        }

        for (Integer i = 0; i < subjects.size(); i++) {
            Course__c course = new Course__c();
            course.Name = 'TestName' + i;
            course.Subject__c = subjects[i].Id;
            Date startDate = Date.today();
            course.Start_Date__c = startDate;
            course.End_Date__c = startDate + 30;
            courses.add(course);
        }

        insert courses;

        Test.startTest();
        LessonsService createLessons = new LessonsService();
        createLessons.formMap((List<sObject>) courses);
        Test.stopTest();

        Integer lessons = [SELECT COUNT() FROM Lesson__c WHERE Course__r.Name LIKE 'TestName%'];

        System.assertEquals(3, lessons);
    }

    @isTest static void testValidateCoursesDate(){
        List<Course__c> courses = new List <Course__c>();
        List<Subject__c> subjects = TestDataFactory.insertSubjects(2);
        List<Id> subjectIds = ListUtility.getIds(Subject__c.Id, subjects);
        List<TimeSlot__c> timeSlots = new List<TimeSlot__c>();
        for (Id subId : subjectIds) {
            timeSlots.addAll(TestDataFactory.insertTimeSlots(1, subId));
        }

        for (Integer i = 0; i < subjects.size(); i++) {
            Course__c course = new Course__c();
            course.Name = 'TestName' + i;
            course.Subject__c = subjects[i].Id;
            Date startDate = Date.today();
            course.Start_Date__c = startDate;
            course.End_Date__c = startDate + 6;
            courses.add(course);
        }

        Test.startTest();
        Database.SaveResult[] saveResults = Database.insert(courses,false);
        Test.stopTest();

        List<String> errors = new List<String>();
        for (Database.SaveResult sr : saveResults) {
            if (!sr.isSuccess()) {
                for(Database.Error err : sr.getErrors()) {
                    errors.add(err.getMessage());
                }
            }
        }
        System.assertEquals('You should choose more days for the correct distribution of lessons', errors[0]);
    }
}