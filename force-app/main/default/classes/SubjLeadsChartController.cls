/**
 * Created by DmytroPinchuk on 04.10.2019.
 */

public with sharing class SubjLeadsChartController {
    @AuraEnabled
    public static List<Data> getLeadsBySubject() {
        List<AggregateResult> aggRes = [
                SELECT Count(Id) quantity, Subject__r.Name
                FROM Lead
                WHERE IsConverted = false
                GROUP BY Subject__r.Name
        ];
        List<Data> data = new List<Data>();
        for (AggregateResult aggregateResult : aggRes) {
            String subjectName = (String) aggregateResult.get('Name');
            Integer leadsQuantity = (Integer) aggregateResult.get('quantity');
            data.add(new Data(subjectName, leadsQuantity));
        }
        return data;
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