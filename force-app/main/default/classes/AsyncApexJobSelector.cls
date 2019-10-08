/**
 * Created by DmytroPinchuk on 08.10.2019.
 */

public with sharing class AsyncApexJobSelector extends QueryBuilder{
    public SObject getJob(Id jobId){
        return (SObject) new QueryBuilder(AsyncApexJob.class)
                .addField('Id')
                .addField('Status')
                .addField('NumberOfErrors')
                .addField('JobItemsProcessed')
                .addField('TotalJobItems')
                .addField('CreatedBy.Email')
                .addConditions().add(new QueryBuilder.CompareCondition('Id').eq(jobId)).endConditions()
                .toSObject();
    }
}