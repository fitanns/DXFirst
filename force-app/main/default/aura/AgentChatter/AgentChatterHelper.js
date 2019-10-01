/**
 * Created by DmytroPinchuk on 23.09.2019.
 */

({
    publishAgentMessage: function (component, publishMessage) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.publishMessage", {
            message: publishMessage
        });
        let myMessages = component.get("v.agentMessages");
        requestMethodResult.then(
            result => {
                myMessages.push(publishMessage.Message__c);
                component.set("v.agentMessages", myMessages);
            },
            error => {
            }
        );
    },
    handleMessage : function (component, message) {
        console.log('mess : ' + JSON.stringify(message));
        let clientMessages = component.get("v.clientMessages");
        if(message.AgentOrClient__c === 'Client'){
            clientMessages.push(message.Message__c);
            component.set('v.clientMessages', clientMessages);
        }
    }
});