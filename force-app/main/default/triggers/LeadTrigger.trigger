/**
 * Created by DmytroPinchuk on 18.09.2019.
 */

trigger LeadTrigger on Lead (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerDispatcher.run(new LeadTriggerHandler());
}