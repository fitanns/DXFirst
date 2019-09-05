/**
 * Created by DmytroPinchuk on 05.09.2019.
 */

({
    doInit : function(component, event, helper) {
        let action = component.get("c.getCourses");
        action.setCallback(this, function(response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                component.set("v.courses", response.getReturnValue());
            }

        });
        $A.enqueueAction(action);
    }
})