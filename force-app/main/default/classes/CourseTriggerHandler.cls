/**
 * Created by DmytroPinchuk on 16.08.2019.
 */

public with sharing class CourseTriggerHandler extends ITriggerHandler {
    public override void AfterInsert(List<sObject> newItems) {

        LessonsService createLessons = new LessonsService();
        createLessons.formMap(newItems);

    }
}