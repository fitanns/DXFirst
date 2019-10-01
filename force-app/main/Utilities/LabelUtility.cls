/**
 * Created by DmytroPinchuk on 19.09.2019.
 */

public with sharing class LabelUtility {
    public static List<String> getLabels(String objName) {

        SObjectType sType = Schema.getGlobalDescribe().get(objName);
        Map<String, Schema.SObjectField> fieldMap = sType.getDescribe().fields.getMap();
        List<String> stringLabels = new List<String>();
        for (SObjectField field : fieldMap.values()) {
            DescribeFieldResult dfr = field.getDescribe();
            String fieldName = dfr.getName();
            String fieldLabel = dfr.getLabel();
            stringLabels.add(fieldLabel);
        }
        return stringLabels;
    }
}