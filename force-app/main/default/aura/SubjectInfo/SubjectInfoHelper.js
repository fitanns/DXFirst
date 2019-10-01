/**
 * Created by DmytroPinchuk on 17.09.2019.
 */

({
    getUrl: function (component) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getUrlsString", {});
        requestMethodResult.then(
            result => component.set("v.communityURL", result),
            error => console.log("Errors", error)
        );
    },
    getSubjectsContImage: function (component, subject) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getSubjectContents", {
            subject: subject
        });
        requestMethodResult.then(
            result => component.set("v.contents", result),
            error => console.log("Errors", error)
        );
    },
    getCourses: function (component, subject) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getSubjectCourses", {
            subject: subject
        });
        requestMethodResult.then(
            result => {
                component.set("v.data", result);
            },
            error => console.log("Errors", error)
        );
    },
    getCourseLabel: function (component) {
        /*        const request = component.find("requestCall");
                const requestMethodResult = request.enqueue("c.getCourseLabels", {});
                requestMethodResult.then(
                    result => {
                        let course = {};
                        for (let i = 0; i < result.length; i++) {
                            let str = result[i],
                                courseLabelKey = str.split(' ').join('');
                            course[courseLabelKey] = result[i];
                        }
                        component.set("v.courseLabels", course);
                    },
                    error => console.log("Errors", error)
                );*/
        const request = component.find("sObjectLabels");
        const labels = request.getLabels("Course__c");

        labels.then(
            result => {
                let sObjectLabels = {};
                for (let i = 0; i < result.length; i++) {
                    let str = result[i],
                        sObjectKey = str.split(' ').join('');
                    sObjectLabels[sObjectKey] = result[i];
                }
                this.setCourseLabels(component,sObjectLabels);
            },
            error => {
                console.log('Error : ' + error);
            }
        );

    },
    getSubjectLabel: function (component) {
        /*        const request = component.find("requestCall");
                const requestMethodResult = request.enqueue("c.getSubjectLabels", {});
                requestMethodResult.then(
                    result => {
                        let subject = {};
                        for (let i = 0; i < result.length; i++) {
                            let str = result[i],
                                subjectLabelKey = str.split(' ').join('');
                            subject[subjectLabelKey] = result[i];
                        }
                        component.set("v.subjectLabels", subject);
                    },
                    error => console.log("Errors", error)
                );*/
        const request = component.find("sObjectLabels");
        const labels = request.getLabels("Subject__c");

        labels.then(
            result => {
                let sObjectLabels = {};
                for (let i = 0; i < result.length; i++) {
                    let str = result[i],
                        sObjectKey = str.split(' ').join('');
                    sObjectLabels[sObjectKey] = result[i];
                }
                component.set("v.subjectLabels", sObjectLabels);
            },
            error => {
                console.log('Error : ' + error);
            }
        );
    },

    setCourseLabels : function (component, courseLabels) {
        component.set('v.columns', [
            {label: courseLabels.CourseName, fieldName: 'Name', type: 'text'},
            {label: courseLabels.StartDate, fieldName: 'Start_Date__c', type: 'date'},
            {label: courseLabels.EndDate, fieldName: 'End_Date__c', type: 'date'},
        ]);
    }

});