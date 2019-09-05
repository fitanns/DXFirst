/**
 * Created by DmytroPinchuk on 03.09.2019.
 */

({
    getLessons: function (component, newDate) {
        let action = component.get("c.getLessonsTimes");
        action.setParams({"ourDate": newDate});
        action.setCallback(this, function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                let lessons = response.getReturnValue();
                formLessons(lessons, component);
            } else if (state === "ERROR") {
                let errors = response.getError();
                console.log(errors);
            } else {
                console.log("Failed with state: " + state);
            }
        });

        function formLessons(lessons, component) {
            let tableHours = [];
            for (let i = 1; i <= 24; i++) {
                let counter = i,
                    am = 'AM';
                if (counter > 12) {
                    am = 'PM';
                    counter = i - 12;
                }
                tableHours.push({
                    time: counter + " " + am,
                    firstTimePart: '',
                    secondTimePart: '',
                });
            }
            formTable(tableHours, lessons);

            function formTable(tableHours, lessons) {
                for (let course in lessons) {
                    tableHours.forEach(function (itemTableHour) {
                        let hours = itemTableHour.time.split(" "),
                            times = lessons[course].split(':'),
                            dayAMPM = (times[0] < 12 || times[0] === 24) ? times[0] : times[0];
                        validateAndFill(hours, times, itemTableHour, course, dayAMPM)
                    })

                }
            }

            function validateAndFill(hours, times, itemTableHour, course, dayAMPM) {
                if (hours[1] === 'AM' && hours[0] == dayAMPM) {
                    if (times[1] < 30) {
                        itemTableHour.firstTimePart = itemTableHour.firstTimePart + " " + lessons[course] + " " + course + " ;";
                    } else {
                        itemTableHour.secondTimePart = itemTableHour.secondTimePart + " " + lessons[course] + " " + course + " ;";
                    }
                }
                if (hours[1] === 'PM' && +hours[0] + 12 == dayAMPM) {
                    if (times[1] < 30) {
                        itemTableHour.firstTimePart = itemTableHour.firstTimePart + " " + lessons[course] + " " + course + " ;";
                    } else {
                        itemTableHour.secondTimePart = itemTableHour.secondTimePart + " " + lessons[course] + " " + course + " ;";
                    }
                }
            }

            component.set("v.tableLessons", tableHours);
        }

        $A.enqueueAction(action);
    }
});