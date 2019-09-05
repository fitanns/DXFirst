/**
 * Created by DmytroPinchuk on 22.08.2019.
 */

({
    doInit: function (component, event, helper) {
        let newDate = component.get("v.currentDate");
            helper.getLessons(component,newDate);
    },
    handleLeftDate: function (component, event, helper) {
        let currDate = component.get("v.currentDate"),
            newDate = new Date(currDate.toString());
        newDate.setDate(newDate.getDate() - 1);
        let month = newDate.getMonth() + 1,
            day = newDate.getDate(),
            year = newDate.getFullYear(),

            nextDate = year + "-" + month + "-" + day,
            days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        component.set("v.currentDate", nextDate);
        component.set("v.dayOfWeek", days[newDate.getDay()]);
        helper.getLessons(component,nextDate);


    }
    ,
    handleRightDate: function (component, event, helper) {
        let currDate = component.get("v.currentDate"),
            newDate = new Date(currDate.toString());
        newDate.setDate(newDate.getDate() + 1);

        let month = newDate.getMonth() + 1,
            day = newDate.getDate(),
            year = newDate.getFullYear(),

            nextDate = year + "-" + month + "-" + day,
            days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        component.set("v.currentDate", nextDate);
        component.set("v.dayOfWeek", days[newDate.getDay()]);
        helper.getLessons(component,nextDate);
    }
    ,
    handleTodayClick: function (component, event, helper) {
        let dateObj = new Date(),
            month = dateObj.getMonth() + 1,
            day = dateObj.getDate(),
            year = dateObj.getFullYear(),
            newdate = year + "-" + month + "-" + day,
            days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
        component.set("v.currentDate", newdate);
        component.set("v.dayOfWeek", days[dateObj.getDay()]);
        helper.getLessons(component,newdate);

    }

});