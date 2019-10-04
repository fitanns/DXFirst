/**
 * Created by DmytroPinchuk on 17.09.2019.
 */

({
    doInit: function (component, event, helper) {
        helper.getUrl(component);
    },
    handleSubject: function (component, event, helper) {
        let subject = event.getParam("subject");
        subject.sObjectType = 'Subject__c';
        console.log('sub : ' + JSON.stringify(subject));

        component.set("v.subject", subject);
        helper.getSubjectsContImage(component, subject);
        helper.getCourses(component, subject);
        helper.getCourseLabel(component);
        helper.getSubjectLabel(component);
    },
    /*    clickCourse: function (component, event, helper) {
            let courseName = component.get("v.courses")[event.currentTarget.dataset.record];
            let subjectEvent = $A.get("e.c:getSelectedCourse");
            subjectEvent.setParams({"name": courseName.Name});
            subjectEvent.fire();
        },*/
    getSelectedName: function (component, event) {
        let selectedRows = event.getParam('selectedRows'),
            subject = component.get("v.subject"),
            subjectEvent = $A.get("e.c:getSelectedCourse");
        subjectEvent.setParams({"name": selectedRows[0].Name, "subjectId": subject.Id});
        subjectEvent.fire();
    }
});