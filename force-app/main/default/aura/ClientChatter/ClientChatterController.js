/**
 * Created by DmytroPinchuk on 23.09.2019.
 */

({
/*    doInit: function (component, event, helper) {
        helper.getSessionId(component);
    },*/
    sendMessage: function (component, event, helper) {
        let clientText = component.find('client-text'),
            publishMessage = {
                Message__c: '',
                AgentOrClient__c: 'Client'
            };
        publishMessage.Message__c = clientText.get('v.value');
        publishMessage.sObjectType = 'Chat_Message__e';
        helper.publishClientMessage(component, publishMessage);
    },
/*    loadedComet: function (component, event, helper) {
/!*        let cometD = new org.cometd.CometD();
        console.log('cometD : ' + JSON.stringify(cometD));
        component.set("v.cometd", cometD);*!/
/!*        if (component.get("v.cometd") != null) {
            helper.connectCometD(component);
        }*!/
        helper.connectCometD(component, event, helper);
    },*/
    handleMessage : function (component, event, helper) {
        console.log('payload : ' + JSON.stringify(event.getParam("payload")));
        let message = event.getParam("payload"),
        agentMessages = component.get("v.agentMessages");
        if(message.AgentOrClient__c === 'Agent'){
            agentMessages.push(message.Message__c);
            component.set('v.agentMessages', agentMessages);
        }
    }
});