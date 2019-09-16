/**
 * Created by DmytroPinchuk on 13.09.2019.
 */

({
    handleSuccess: function (component, event, helper) {
        helper.showSuccessAlert(component, event);
    },
    handleError: function (component, event, helper) {
        helper.showErrorAlert(component, event);
    },
    closeSuccessWindow: function (component, event, helper) {
        component.set("v.showSuccess", false);
    },
    closeErrorWindow: function (component, event, helper) {
        component.set("v.showError", false);
    }
});