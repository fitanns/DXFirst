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
        for (Lead lead : leads) {
            if (!countsLeadsOfSubjects.containsKey(lead.Subject__r.Name)) {
                countsLeadsOfSubjects.put(lead.Subject__r.Name, 1);
            } else {
                Integer count = countsLeadsOfSubjects.get(lead.Subject__r.Name);
                countsLeadsOfSubjects.put(lead.Subject__r.Name, count + 1);
            }
        }
    }

    public void finish(Database.BatchableContext param1) {
        AsyncApexJobSelector jobSelector = new AsyncApexJobSelector();
        AsyncApexJob job = (AsyncApexJob) jobSelector.getJob(param1.getJobId());
        if (job.Status == 'Completed') {
            LeadsBySubjectSelector leadsBySubjectSelector = new LeadsBySubjectSelector();
            List<SubjectsLeadsData__c> subjectsLeadsData = leadsBySubjectSelector.subjectsLeadsDataByName(countsLeadsOfSubjects.keySet());

            if (subjectsLeadsData.size() > 0) {
                for (Integer i = 0; i < subjectsLeadsData.size(); i++) {
                    subjectsLeadsData[i].Quantity__c = countsLeadsOfSubjects.get(subjectsLeadsData[i].Name);
                }
            } else {
                for (String subject : countsLeadsOfSubjects.keySet()) {
                    subjectsLeadsData.add(new SubjectsLeadsData__c(Name = subject, Quantity__c = countsLeadsOfSubjects.get(subject)));
                }
            }
            upsert subjectsLeadsData;
            Batch_Completed__e batchCompleted = new Batch_Completed__e();
            PublishPlatformEventService publish = new PublishPlatformEventService();
            publish.publishMessage(batchCompleted);
        }
    }
}
