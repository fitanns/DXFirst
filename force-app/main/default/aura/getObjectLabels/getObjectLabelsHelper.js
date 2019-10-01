/**
 * Created by DmytroPinchuk on 24.09.2019.
 */

({
    getLabels: function (component, event) {
        let args = event.getParam("arguments"),
            objectName = '';
        if (!$A.util.isEmpty(args.objectName)) {
            objectName = args.objectName;
        }

        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getSObjectLabels", {
            objectName: objectName
        });
        return requestMethodResult;
    }
});