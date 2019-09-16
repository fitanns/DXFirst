/**
 * Created by DmytroPinchuk on 11.09.2019.
 */

({
    getCourseLabel: function (component) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getCourseLabels", {});
        requestMethodResult.then(
            result => {
                let course = {};
                for (let i = 0; i < result.length; i++) {
                    let str = result[i],
                        courseLabelKey = str.replace(' ', '');
                    course[courseLabelKey] = result[i];
                }
                component.set("v.courseLabels", course);
            },
            error => console.log("Errors", error)
        );
    },

    getContentsImage: function (component, course) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getContents", {
            course: JSON.stringify(course)
        });
        requestMethodResult.then(
            result => component.set("v.contents", result),
            error => console.log("Errors", error)
        );
    },
    getUrl: function (component) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getUrlsString", {});
        requestMethodResult.then(
            result => component.set("v.communityURL", result),
            error => console.log("Errors", error)
        );
    }
});