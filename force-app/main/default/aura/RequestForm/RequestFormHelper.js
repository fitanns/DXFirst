/**
 * Created by DmytroPinchuk on 09.09.2019.
 */

({
    getLeads: function (component) {

        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getLeadFields", {});
        requestMethodResult.then(
            result => {
                let someLead = {};
                for (let i = 0; i < result.length; i++) {
                    someLead[result[i]] = result[i];
                }
                component.set("v.someLead", someLead);
            },
            error => console.log("Errors", error)
        );
    },

    getFieldSet: function (component) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getFieldSetField", {});
        requestMethodResult.then(
            result => {
                component.set("v.fieldSet", result);
            },
            error => console.log("Errors", error)
        );
    },

    createRequestLead: function (component, newLead) {

        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.saveRequestLead", {
            newLead: newLead
        });
        requestMethodResult.then(
            result => {
                const successAlert = component.find("showAlert");
                successAlert.success();

            },
            error => {
                const successAlert = component.find("showAlert");
                successAlert.error(error);
            }
        );
    }
});