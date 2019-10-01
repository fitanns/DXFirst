/**
 * Created by DmytroPinchuk on 23.09.2019.
 */

({
    doInit: function (component, event, helper) {
        let empApi = component.find('empApi'),
            channel = component.get('v.channelName'),
            replayId = -1;

        empApi.subscribe("/event/Chat_Message__e", -1, $A.getCallback(searchResult => {
            helper.handleMessage(component, searchResult.data.payload);
            console.log('asd : ' + JSON.stringify(searchResult.data.payload));
        })).then(subscription => {
            component.set('v.subscription', subscription);
        }).catch(error => {
            console.log(JSON.stringify(error));
        });
    },
    sendMessage: function (component, event, helper) {
        let agentChat = component.find('agent-text'),
            publishMessage = {
                Message__c: '',
                AgentOrClient__c: 'Agent'
            };
        publishMessage.Message__c = agentChat.get('v.value');
        publishMessage.sObjectType = 'Chat_Message__e';
        helper.publishAgentMessage(component, publishMessage);

    },
    handleLabelsEvent: function (component, event, helper) {
        component.set("v.Labels", event.getParams("labels"));
    }
});