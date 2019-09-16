/**
 * Created by DmytroPinchuk on 05.09.2019.
 */

({
    courseClick : function (component, event, helper) {
        let course = component.get("v.course"),
            courseEvent = $A.get("e.c:getCourseInfo");
        courseEvent.setParams({"course" : course});
        courseEvent.fire();
    }
});