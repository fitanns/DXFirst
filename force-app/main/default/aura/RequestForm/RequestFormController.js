/**
 * Created by DmytroPinchuk on 09.09.2019.
 */

({
    doInit: function (component, event, helper) {
        let someLead = component.get("v.someLead");
        helper.getLeads(component);
        helper.getFieldSet(component);
    },
    createRequest: function (component, event, helper) {

        let requestForm = component.find('requestform'),
            values = {
                FirstName: "",
                LastName: "",
                MobilePhone: "",
                Email: "",
                Company: "",
            };

        let counter = 0;
        for (let key in values) {
            values[key] = requestForm[counter].get('v.value');
            counter++;
        }
        console.log(values);
        helper.createRequestLead(component, values);
    },
});