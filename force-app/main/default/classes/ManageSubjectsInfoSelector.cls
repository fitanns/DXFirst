/**
 * Created by DmytroPinchuk on 09.10.2019.
 */

public with sharing class ManageSubjectsInfoSelector extends QueryBuilder {
    public List<ManageSubjectsInfo__mdt> getManageSubjectsInfo(String subjectService) {
        return (List<ManageSubjectsInfo__mdt>) new QueryBuilder(ManageSubjectsInfo__mdt.class)
                .addField('SubjectService__c')
                .addConditions()
                .add(new QueryBuilder.CompareCondition('SubjectService__c').eq(subjectService))
                .endConditions()
                .toList();
    }
}
