/**
 * Created by DmytroPinchuk on 05.09.2019.
 */

({
    doInit : function (component, event, helper) {
        helper.getUrl(component);
    },

    handleCourse: function (component, event, helper) {
        let course = event.getParam("course");
        component.set("v.course", course);
        helper.getCourseLabel(component);
        helper.getContentsImage(component, course);
    },
});