/**
 * Created by DmytroPinchuk on 26.09.2019.
 */

public with sharing class SubjectSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Subject__c.Lesson_Duration__c,
                Subject__c.Id,
                Subject__c.Number_of_Lessons__c,
                Subject__c.Name
        };
    }
    public Schema.SObjectType getSObjectType() {
        return Subject__c.sObjectType;
    }

    public List<Subject__c> selectSubject() {
        return (List<Subject__c>) Database.query(
                newQueryFactory().
                        toSOQL()

        );
    }
}