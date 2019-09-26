/**
 * Created by DmytroPinchuk on 30.08.2019.
 */

public with sharing class MapUtility {
    public static Map<Object, List<SObject>> groupRecordsByFieldValue(SObjectField idField, List<SObject> records, Type mapType, Type sObjectListType) {
        Map<Object, List<SObject>> recordsByValue = (Map<Object, List<SObject>>) mapType.newInstance();
        for (SObject record : records) {
            Object mappingValue = record.get(idField);
            List<SObject> mappedRecords = recordsByValue.get(mappingValue);
            if (mappedRecords == null) {
                mappedRecords = (List<SObject>) sObjectListType.newInstance();
                recordsByValue.put(mappingValue, mappedRecords);
            }
            mappedRecords.add(record);
        }
        return recordsByValue;
    }

    public static Map<Id, List<sObject>> groupRecordByIds (SObjectField idField, List<sObject> records, Type mapType, Type sObjectListType){
        Map<Id, List<sObject>> groupRecordsByIdField = (Map<Id, List<SObject>>) mapType.newInstance();

        for (sObject record : records) {
            Id mappingId = (Id)record.get(idField);
            if (!groupRecordsByIdField.containsKey(mappingId)) {
                groupRecordsByIdField.put(mappingId, (List<SObject>) sObjectListType.newInstance());
            }
            groupRecordsByIdField.get(mappingId).add(record);
        }
        return groupRecordsByIdField;
    }

    public static Map<Id, sObject> groupRecordToMapByIds (SObjectField idField, List<sObject> records, Type mapType, Type sObjectType){
        Map<Id,sObject> groupRecordsByIdField = (Map<Id, SObject>) mapType.newInstance();

        for (sObject record : records) {
            Id mappingId = (Id)record.get(idField);
            if (!groupRecordsByIdField.containsKey(mappingId)) {
                groupRecordsByIdField.put(mappingId, (SObject)sObjectType.newInstance());
            }
            groupRecordsByIdField.put(mappingId,record);
        }
        return groupRecordsByIdField;
    }
}