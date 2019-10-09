/**
 * Created by DmytroPinchuk on 04.10.2019.
 */

({
    doInit: function (component, event, helper) {
        // helper.subscribeToEvent(component);
    },
    chartLoaded: function (component, event, helper) {
        // helper.getLeadsBySubjects(component);
        // helper.fireFormData(component);
        helper.getData(component);
    }
});