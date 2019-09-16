/**
 * Created by DmytroPinchuk on 12.09.2019.
 */

({
    request: function (component, event) {
        let args = event.getParam("arguments");
        let action = component.get("v.context").get(args.actionName);
        action.setParams(args.params);
        return new Promise((resolve, reject) => {
            component.set("v.spinner", true);

            action.setCallback(this, (response) => {
                if (response.getState() == "SUCCESS") {
                    resolve(response.getReturnValue());
                } else {
                    let errors = response.getError();
                    reject(errors);
                }
                component.set("v.spinner", false);
            })
            $A.enqueueAction(action);
        });
    }
});