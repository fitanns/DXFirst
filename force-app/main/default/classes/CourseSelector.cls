/**
 * Created by DmytroPinchuk on 26.09.2019.
 */

public with sharing class CourseSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Course__c.Start_Date__c,
                Course__c.Id,
                Course__c.End_Date__c,
                Course__c.Name
        };
    }
    public Schema.SObjectType getSObjectType() {
        return Course__c.sObjectType;
    }

    public List<Course__c> selectBySubjectId(Id ids) {
        return (List<Course__c>) Database.query(
                newQueryFactory().
                        setCondition('Subject__c =: ids').
                        toSOQL()

        );
    }
}