/**
 * Created by DmytroPinchuk on 17.09.2019.
 */

({
    getSubjects: function (component) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getSubjects", {});
        requestMethodResult.then(
            result => component.set("v.subjects", result),
            error => console.log("Errors", error)
        );
    }
});