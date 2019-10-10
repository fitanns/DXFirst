/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

public with sharing class OpportunityTriggerHandler extends ITriggerHandler {
    public override void AfterInsert(List<sObject> newItems) {
        OpportunityService opportunityService = new OpportunityService();
        opportunityService.sendSmsToClient(newItems);
    }
}