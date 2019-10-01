/**
 * Created by DmytroPinchuk on 26.09.2019.
 */

@IsTest
private class SubjectInfoControllerTest {
    @IsTest
    static void testUrl() {
        String urlString = SubjectInfoController.getUrlsString();
        System.assertEquals(urlString != null, true);
    }
    @IsTest
    static void testSubjectContents() {
        List<Subject__c> subjects = TestDataFactory.insertSubjects(1);
        Test.startTest();
        List<ContentVersion> cv = SubjectInfoController.getSubjectContents(subjects[0]);
        Test.stopTest();
        System.assertEquals(cv.isEmpty(), true);

    }
    @IsTest
    static void testSubjectCourses() {
        List<Subject__c> subjects = TestDataFactory.insertSubjects(1);
        List<TimeSlot__c> timeSlots = TestDataFactory.insertTimeSlots(1,subjects[0].Id);
        List<Course__c> courses = TestDataFactory.insertCourses(1, subjects[0]);
        Test.startTest();
        List<Course__c> coursesList = SubjectInfoController.getSubjectCourses(subjects[0]);
        Test.stopTest();
        System.assertEquals(1, coursesList.size());
    }
}