/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

trigger OpportunityTrigger on Opportunity (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerDispatcher.run(new OpportunityTriggerHandler());
}