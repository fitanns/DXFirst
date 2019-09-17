/**
 * Created by DmytroPinchuk on 13.09.2019.
 */

({
    showSuccessAlert: function (component, event) {
        let args = event.getParam("arguments"),
            params = '';
        if (!$A.util.isEmpty(args.params)) {
            params = args.params;
        }
        component.set("v.successMessage", params);
        component.set("v.showSuccess", true);
    },
    showErrorAlert: function (component, event) {
        let args = event.getParam("arguments"),
            error = {};
        if (!$A.util.isEmpty(args.params)) {
            error = args.params;
        }
        console.log(error);
        component.set("v.errorMessage", error);
        component.set("v.showError", true);
    }
});