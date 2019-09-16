/**
 * Created by DmytroPinchuk on 09.09.2019.
 */

({
    handleCourse: function (component, event, helper) {
        let course = event.getParam("course");
        component.set("v.course", course);
        let action = component.get("c.getContents");
        action.setParams({"course": JSON.stringify(course)});
        action.setCallback(this, function(response) {
            let state = response.getState();
            if(component.isValid() && state === 'SUCCESS') {
                console.log(response.getReturnValue());
                component.set("v.contents", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);

    },
    // doInit : function(component){
    //     component.set("v.auraBr", " <br>");
    // }
});