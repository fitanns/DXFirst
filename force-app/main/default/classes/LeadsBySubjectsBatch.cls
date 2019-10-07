/**
 * Created by DmytroPinchuk on 07.10.2019.
 */

public with sharing class LeadsBySubjectsBatch implements Database.Batchable<sObject>, Database.Stateful {
    public String query { get; set; }
    Map<String, Integer> countsLeadsOfSubjects = new Map<String, Integer>();

    public Database.QueryLocator start(Database.BatchableContext BC) {
/*        String leadQuery = 'SELECT Count(Id), Subject__r.Name FROM Lead WHERE IsConverted = false GROUP BY Subject__r.Name';
        return new AggregateResultIterable(leadQuery);*/
//        'SELECT Count(Id), Subject__r.Name FROM Lead WHERE IsConverted = false GROUP BY Subject__r.Name'
        return Database.getQueryLocator('SELECT Id, Subject__r.Name FROM Lead WHERE IsConverted = false');
    }


    public void execute(Database.BatchableContext param1, List<Lead> leads) {
        for (Lead lead : leads) {
            if (!countsLeadsOfSubjects.containsKey(lead.Subject__r.Name)) {
                countsLeadsOfSubjects.put(lead.Subject__r.Name, 1);
            } else {
                Integer count = countsLeadsOfSubjects.get(lead.Subject__r.Name);
                countsLeadsOfSubjects.put(lead.Subject__r.Name, count + 1);
            }
        }
/*       List<SubjectsLeadsData__c> data = new List<SubjectsLeadsData__c>();
        for (AggregateResult aggregateResult : aggRes) {
            String subjectName = (String) aggregateResult.get('Name');
            Integer leadsQuantity = (Integer) aggregateResult.get('expr0');
            data.add(new SubjectsLeadsData__c(Name = subjectName, Quantity__c = leadsQuantity));
        }
        upsert data;*/
    }

    public void finish(Database.BatchableContext param1) {
        AsyncApexJob job = [
                SELECT Id, Status, NumberOfErrors,
                        JobItemsProcessed,
                        TotalJobItems, CreatedBy.Email
                FROM AsyncApexJob
                WHERE Id = :param1.getJobId()
        ];
        if (job.Status == 'Completed') {
            List<SubjectsLeadsData__c> subjectsLeadsData = [SELECT Id,Name,Quantity__c FROM SubjectsLeadsData__c];
//            List<SubjectsLeadsData__c> data = new List<SubjectsLeadsData__c>();
            for (String subject : countsLeadsOfSubjects.keySet()) {
                for(Integer i = 0; i < subjectsLeadsData.size(); i++){
                    if(subjectsLeadsData[i].Name == subject){
                        subjectsLeadsData[i].Quantity__c = countsLeadsOfSubjects.get(subject);
                    }else{
                        subjectsLeadsData.add(new SubjectsLeadsData__c(Name = subject, Quantity__c = countsLeadsOfSubjects.get(subject)));
                    }
                }
            }
            upsert subjectsLeadsData;
            Batch_Completed__e batchCompleted = new Batch_Completed__e();
            PublishPlatformEventService publish = new PublishPlatformEventService();
            publish.publishMessage(batchCompleted);
        }


    }
}