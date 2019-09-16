/**
 * Created by DmytroPinchuk on 06.09.2019.
 */

public with sharing class RequestFormController {

    @AuraEnabled
    public static void saveRequestLead(String newLead){

        Lead futureLead = (Lead)JSON.deserialize(newLead,Lead.class);
        futureLead.Status = 'Open - Not Contacted';
        insert futureLead;
    }

    @AuraEnabled
    public static List<String> getLeadFields(){
        Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Lead.fields.getMap();
        List<String> leadFields = new List<String>();
        for(SObjectField field : fieldMap.values()){
            DescribeFieldResult dfr = field.getDescribe();
            String fieldName = dfr.getName();
            leadFields.add(fieldName);
        }
        return leadFields;
    }

    @AuraEnabled
    public static List<FieldSetFields> getFieldSetField(){

        List<FieldSetFields> fieldsList = new List<FieldSetFields>();
        String objectName = 'Lead';
        Schema.SObjectType sObjType = Schema.getGlobalDescribe().get(objectName);
        Map<String, Schema.FieldSet> fieldSetNameRecord = sObjType.getDescribe().fieldsets.getMap();
        Schema.FieldSet fieldSet = fieldSetNameRecord.get('FieldSetRegister');
        List<Schema.FieldSetMember>fieldSetMembers = fieldSet.getFields();
        for(Schema.FieldSetMember fieldSetMember : fieldSetMembers){
            FieldSetFields fieldsFS = new FieldSetFields(fieldSetMember);
            fieldsList.add(fieldsFS);
        }
        return fieldsList;
    }

}