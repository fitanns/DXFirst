/**
 * Created by DmytroPinchuk on 16.08.2019.
 */

public with sharing class TriggerDispatcher {
    public static Boolean isEnabled = true;
    public static void run(ITriggerHandler handler) {
        if (isEnabled) {
            if (Trigger.isBefore) {
                if (Trigger.isInsert) {
                    handler.BeforeInsert(Trigger.new);
                }
                if (Trigger.isUpdate) {
                    handler.BeforeUpdate(Trigger.new, Trigger.oldMap);
                }
                if (Trigger.isDelete) {
                    handler.BeforeDelete(Trigger.old);
                }
            }
            if (Trigger.isAfter) {
                if (Trigger.isInsert) {
                    handler.AfterInsert(Trigger.new);
                }
                if (Trigger.isUpdate) {
                    handler.AfterUpdate(Trigger.new, Trigger.oldMap);
                }
                if (Trigger.isDelete) {
                    handler.AfterDelete(Trigger.old);
                }
                if (Trigger.isUndelete) {
                    handler.AfterUndelete(Trigger.new);
                }
            }
        }
    }
}