/**
 * Created by DmytroPinchuk on 08.10.2019.
 */

public with sharing class SubjectsLeadsDataService {
    public void formOrUpdateData(List<SubjectsLeadsData__c> subjectsLeadsData, Map<String, Integer> countsLeadsOfSubjects) {
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(
                new Schema.SObjectType[]{
                        SubjectsLeadsData__c.SObjectType
                });
        if (subjectsLeadsData.size() > 0) {
            for (Integer i = 0; i < subjectsLeadsData.size(); i++) {
                subjectsLeadsData[i].Quantity__c = countsLeadsOfSubjects.get(subjectsLeadsData[i].Name);
                uow.registerDirty(subjectsLeadsData[i]);
            }
        } else {
            for (String subject : countsLeadsOfSubjects.keySet()) {
                uow.registerNew(new SubjectsLeadsData__c(Name = subject, Quantity__c = countsLeadsOfSubjects.get(subject)));
            }
        }
        uow.commitWork();
    }
}