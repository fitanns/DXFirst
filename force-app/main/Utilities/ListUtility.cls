/**
 * Created by DmytroPinchuk on 20.08.2019.
 */

public with sharing class ListUtility {
    public static List<Id> getIds(SObjectField field, List<SObject> records) {
        List<Id> ids = new List<Id>();
        for (SObject record : records) {
            ids.add((Id) record.get(field));
        }
        return ids;

    }
}