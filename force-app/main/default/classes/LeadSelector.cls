/**
 * Created by DmytroPinchuk on 04.10.2019.
 */

public with sharing class LeadSelector extends QueryBuilder {
    public List<Lead> leadsBySubject() {
        return (List<Lead>) new QueryBuilder(Lead.class)
                .addCountByField('Id')
                .addField('Subject__r.Name')
                .addConditions().add(new QueryBuilder.SimpleCondition('IsConverted = false')).endConditions()
                .toList();
    }
}