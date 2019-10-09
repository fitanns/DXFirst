/**
 * Created by DmytroPinchuk on 09.10.2019.
 */

public with sharing class SubjectQuerySelector extends QueryBuilder{
    public List<Subject__c> getSubjectsByName(String subjectName) {
        return (List<Subject__c>) new QueryBuilder(Subject__c.class)
                .addField('Id')
                .addField('Name')
                .addField('Number_of_Lessons__c')
                .addField('Lesson_Duration__c')
                .addConditions()
                .add(new QueryBuilder.CompareCondition('Name').eq(subjectName))
                .endConditions()
                .toList();
    }
}