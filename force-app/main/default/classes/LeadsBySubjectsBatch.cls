/**
 * Created by DmytroPinchuk on 07.10.2019.
 */

public with sharing class LeadsBySubjectsBatch implements Database.Batchable<sObject>, Database.Stateful {
    public String query { get; set; }
    Map<String, Integer> countsLeadsOfSubjects = new Map<String, Integer>();

    public Database.QueryLocator start(Database.BatchableContext BC) {
/*        String leadQuery = 'SELECT Count(Id), Subject__r.Name FROM Lead WHERE IsConverted = false GROUP BY Subject__r.Name';
        return new AggregateResultIterable(leadQuery);
        'SELECT Count(Id), Subject__r.Name FROM Lead WHERE IsConverted = false GROUP BY Subject__r.Name' */
        return Database.getQueryLocator('SELECT Id, Subject__r.Name FROM Lead WHERE IsConverted = false');
    }

    public void execute(Database.BatchableContext param1, List<Lead> leads) {
        LeadService leadService = new LeadService();
        countsLeadsOfSubjects.putAll(leadService.formLeadsBySubject(leads));
    }

    public void finish(Database.BatchableContext param1) {
        AsyncApexJobSelector jobSelector = new AsyncApexJobSelector();
        AsyncApexJob job = (AsyncApexJob) jobSelector.getJob(param1.getJobId());
        if (job.Status == 'Completed') {
            LeadsBySubjectsBatch.insertOrUpdateData(countsLeadsOfSubjects);
        }
        if (job.Status == 'Failed') {
            LeadsBySubjectsBatch.failedEvent();
        }
    }
    public static void insertOrUpdateData(Map<String, Integer> countsLeadsOfSubjects) {
        LeadsBySubjectSelector leadsBySubjectSelector = new LeadsBySubjectSelector();
        List<SubjectsLeadsData__c> subjectsLeadsData = leadsBySubjectSelector.subjectsLeadsDataByName(countsLeadsOfSubjects.keySet());

        SubjectsLeadsDataService sldService = new SubjectsLeadsDataService();
        sldService.formOrUpdateData(subjectsLeadsData, countsLeadsOfSubjects);

        Batch_Completed__e batchCompleted = new Batch_Completed__e();
        batchCompleted.Status__c = 'Completed';
        PublishPlatformEventService publish = new PublishPlatformEventService();
        publish.publishMessage(batchCompleted);
    }
    public static void failedEvent(){
        Batch_Completed__e batchCompleted = new Batch_Completed__e();
        batchCompleted.Status__c = 'Failed';
        PublishPlatformEventService publish = new PublishPlatformEventService();
        publish.publishMessage(batchCompleted);
    }
}
