/**
 * Created by DmytroPinchuk on 05.09.2019.
 */

public with sharing class ListCoursesController {

    @AuraEnabled
    public static List<Course__c> getCourses() {
        List<Course__c> courses = [SELECT Id,Name, Start_Date__c, End_Date__c, Subject__r.Name FROM Course__c];
        return courses;
    }
}