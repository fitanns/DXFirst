/**
 * Created by DmytroPinchuk on 04.10.2019.
 */

public with sharing class SubjLeadsChartController {
    @AuraEnabled
    public static List<Data> getLeadsBySubject() {
        LeadsBySubjectSelector subjectSelector = new LeadsBySubjectSelector();
        List<AggregateResult> aggRes = subjectSelector.leadsBySubjects();
        List<Data> data = new List<Data>();
        for (AggregateResult aggregateResult : aggRes) {
            String subjectName = (String) aggregateResult.get('Name');
            Integer leadsQuantity = (Integer) aggregateResult.get('expr0');
            data.add(new Data(subjectName, leadsQuantity));
        }
        return data;
    }
    @AuraEnabled
    public static void fireBatchToFormData() {
        LeadsBySubjectsBatch batch = new LeadsBySubjectsBatch();
        Id batchId = Database.executeBatch(batch);
        AsyncApexJobSelector jobSelector = new AsyncApexJobSelector();
        AsyncApexJob job = (AsyncApexJob) jobSelector.getJob(batchId);

    }

    @AuraEnabled
    public static List<SubjectsLeadsData__c> getSubjectsLeadsData() {
        LeadsBySubjectSelector leadsBySubjectSelector = new LeadsBySubjectSelector();
        List<SubjectsLeadsData__c> subjectsLeads = leadsBySubjectSelector.subjectsLeadsData();
        return subjectsLeads;
    }


    public class Data {
        public Data(String label, Integer quantity) {
            this.label = label;
            this.quantity = quantity;
        }
        @AuraEnabled
        public String label { get; set; }
        @AuraEnabled
        public Integer quantity { get; set; }
    }
}