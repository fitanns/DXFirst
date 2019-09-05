/**
 * Created by DmytroPinchuk on 16.08.2019.
 */

public abstract with sharing class ITriggerHandler {
    public virtual void BeforeInsert(List<SObject> newItems) {
    }

    public virtual void BeforeUpdate(List<SObject> newItems, Map<Id, SObject> oldItems) {
    }

    public virtual void BeforeDelete(List<SObject> oldItems) {
    }

    public virtual void AfterInsert(List<SObject> newItems) {
    }

    public virtual void AfterUpdate(List<SObject> newItems, Map<Id, SObject> oldItems) {
    }

    public virtual void AfterDelete(List<SObject> oldItems) {
    }

    public virtual void AfterUndelete(List<SObject> newItems) {
    }

}