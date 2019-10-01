/**
 * Created by DmytroPinchuk on 24.09.2019.
 */

({
    onReceiveNotification: function (component, message) {
        const newNotification = {
            time: $A.localizationService.formatDateTime(
                message.data.payload.CreatedDate, 'HH:mm'),
            message: message.data.payload.Message__c
        };
        this.displayToast(component, 'info', newNotification.message);
    },

    displayToast: function (component, type, message) {
        const toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({
            type: type,
            message: message
        });
        toastEvent.fire();
    }
});