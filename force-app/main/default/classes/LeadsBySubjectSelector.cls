/**
 * Created by DmytroPinchuk on 07.10.2019.
 */

public with sharing class LeadsBySubjectSelector extends QueryBuilder {

    public List<AggregateResult> leadsBySubjects() {
        return (List<AggregateResult>)new QueryBuilder(Lead.class)
                .addCountByField('Id')
                .addField('Subject__r.Name')
                .addConditions().add(new QueryBuilder.SimpleCondition('IsConverted = false')).endConditions()
                .addGroupBy('Subject__r.Name')
                .toList();

    }
    public List<SubjectsLeadsData__c> subjectsLeadsData(){
        return (List<SubjectsLeadsData__c>) new QueryBuilder(SubjectsLeadsData__c.class)
                .addField('Name')
                .addField('Quantity__c')
                .toList();
    }
}