/**
 * Created by DmytroPinchuk on 24.09.2019.
 */

public with sharing class getObjectLabelsController {

    @AuraEnabled
    public static List<String> getSObjectLabels(String objectName) {
        List<String> sObjectLabels = LabelUtility.getLabels(objectName);
        return sObjectLabels;
    }
}