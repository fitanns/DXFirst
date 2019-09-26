/**
 * Created by DmytroPinchuk on 21.08.2019.
 */

public with sharing class TestDataFactory {

    public static List<Subject__c> insertSubjects(Integer numberOfSubjects) {
        List<Subject__c> subjects = new List<Subject__c>();
        for (Integer i = 1; i <= numberOfSubjects; i++) {
            subjects.add(new Subject__c(Name = 'SomeSubject' + i, Number_of_Lessons__c = i));
        }
        insert subjects;
        return subjects;
    }

    public static List<TimeSlot__c> insertTimeSlots(Integer numberOfTimeSlots, Id subjectId) {
        List<TimeSlot__c> timeSlots = new List<TimeSlot__c>();
        for (Integer i = 1; i <= numberOfTimeSlots; i++) {
            timeSlots.add(new TimeSlot__c(DayOfWeek__c = 'Monday',
                    Time__c = Time.newInstance(09 + i, 00, 00, 00), Subject__c = subjectId));
        }
        insert timeSlots;
        return timeSlots;
    }

    public static List<Lead> insertLeads(Integer numberOfLeads) {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 1; i <= numberOfLeads; i++) {
            leads.add(new Lead(FirstName = 'TestName' + i, LastName = 'LastTestName' + i,
                    Company = 'TestCompanyName' + i, Status = 'Open - Not Contacted', Email = 'somtestemail'+ i + '@gmail.com'));
        }
        insert leads;
        return leads;
    }
    public static List<Lead> formPotentialLeads(Integer numberOfLeads) {
        List<Lead> leads = new List<Lead>();
        for (Integer i = 1; i <= numberOfLeads; i++) {
            leads.add(new Lead(FirstName = 'TestName' + i, LastName = 'LastTestName' + i,
                    Company = 'TestCompanyName' + i,Email = 'somtestemail'+ i + '@gmail.com'));
        }
        return leads;
    }
    public static List<Lead> updateToApproval(List<Lead> leads){
        List<Lead> approvedLeads = new List<Lead>();
        for(Lead lead : leads){
            lead.ApprovalStatus__c = 'Approved';
            approvedLeads.add(lead);
        }
        update approvedLeads;
        return approvedLeads;
    }
    public static List<Lead> updateToRejected(List<Lead> leads){
        List<Lead> rejectedLeads = new List<Lead>();
        for(Lead lead : leads){
            lead.ApprovalStatus__c = 'Rejected';
            rejectedLeads.add(lead);
        }
        update rejectedLeads;
        return rejectedLeads;
    }
}