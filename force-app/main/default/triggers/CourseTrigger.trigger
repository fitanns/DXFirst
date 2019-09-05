/**
 * Created by DmytroPinchuk on 16.08.2019.
 */

trigger CourseTrigger on Course__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    TriggerDispatcher.run(new CourseTriggerHandler());
}