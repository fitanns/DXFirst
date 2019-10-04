/**
 * Created by DmytroPinchuk on 04.10.2019.
 */

public with sharing class LeadSelector extends fflib_SObjectSelector {

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                Lead.Id
        };
    }
    public Schema.SObjectType getSObjectType() {
        return Lead.sObjectType;
    }

    public List<Lead> selectLeadsBySubjects() {
//        List<LeadInfo> leadInfos = new List<LeadInfo>();
        /*       for (Lead lead : Database.query(
                       newQueryFactory(false).
                               selectField(Lead.Id).

                               selectField('Subject__r.Name').
                               setCondition('IsConverted = false').
                               toSOQL()

               ))
                   leadInfos.add(new LeadInfo(lead));
               return leadInfos;*/
        return (List<Lead>) Database.query(
                newQueryFactory().
                        selectField(Subject__c.Name).
                        setCondition('IsConverted = false').
                        toSOQL()
        );
        /*       List<AggregateResult> aggRes =  [SELECT Count(Id), Subject__r.Name FROM Lead WHERE IsConverted = false GROUP BY Subject__r.Name ];
               System.debug(aggRes);*/

    }
    public class LeadInfo {
        private Lead lead;
        public String Name { get {return lead.Subject__r.Name;} }

        private LeadInfo(Lead lead) {
            this.lead = lead;
        }
    }
}