/**
 * Created by DmytroPinchuk on 05.09.2019.
 */

global with sharing class ListCoursesController {

    @AuraEnabled
    global static List<Course__c> getCourses() {
        List<Course__c> courses = [SELECT Id,Name, Start_Date__c, End_Date__c, Subject__c FROM Course__c];
        return courses;
    }
}