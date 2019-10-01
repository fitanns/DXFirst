/**
 * Created by DmytroPinchuk on 17.09.2019.
 */

({
    subjectClick: function (component, event, helper) {
        let subject = component.get("v.subject"),
            subjectEvent = $A.get("e.c:getSubjectInfo");
        subjectEvent.setParams({"subject": subject});
        subjectEvent.fire();
    }
});