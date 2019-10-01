/**
 * Created by DmytroPinchuk on 26.09.2019.
 */

public with sharing class SetUtility {
    public static Set<Id> getIds(SObjectField field, List<SObject> records) {
        Set<Id> ids = new Set<Id>();
        for (SObject record : records) {
            ids.add((Id) record.get(field));
        }
        return ids;

    }
}