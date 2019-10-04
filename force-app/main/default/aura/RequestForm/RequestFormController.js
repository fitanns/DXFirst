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

        let requestForm = component.find('requestform');
        /*    let asd = event.currentTarget;
            let resa = asd.getAttribute('data-api-name');
            console.log('data : ' + resa);*/

        let lead = {};
        for (let i = 0; ; i++) {
            if (requestForm[i] === undefined) {
                break;
            } else {
                let key = requestForm[i].get('v.label'),
                    value = requestForm[i].get('v.value');

                lead[key] = value;
            }
        }
        lead.sObjectType = 'Lead';
        lead.Subject__c = component.get("v.subjectId");
        console.log('dsub : ' + component.get("v.subjectId"));
        console.log('dsuasdb : ' + lead.Subject__c);

        helper.createRequestLead(component, lead);
    },
    handleSubjectName: function (component, event, helper) {
        let courseName = event.getParam("name"),
            subjectId = event.getParam("subjectId");
        component.set("v.showCourse", true);
        component.set("v.selectedCourse", courseName);
        component.set("v.subjectId", subjectId);
    }
});