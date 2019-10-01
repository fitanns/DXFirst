/**
 * Created by DmytroPinchuk on 23.09.2019.
 */

({
    publishClientMessage: function (component, publishMessage) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.publishClientMessage", {
            message: publishMessage
        });
        let myMessages = component.get("v.clientMessages");
        requestMethodResult.then(
            result => {
                myMessages.push(publishMessage.Message__c);
                component.set("v.clientMessages", myMessages);
            },
            error => {

            }
        );
    },
    getSessionId: function (component) {
        const request = component.find("requestCall");
        const requestMethodResult = request.enqueue("c.getSessionId", {});
        requestMethodResult.then(
            result => {
                component.set("v.sessionId", result);
            },
            error => {
            }
        );
    },
    connectCometD : function (component) {
        let cometD = new window.org.cometd.CometD(),
            sessionId = component.get("v.sessionId");
        cometD.configure({
            url: window.location.protocol + '//' + window.location.hostname + '/cometd/41.0/',
            requestHeaders: { Authorization: 'OAuth' + sessionId},
            appendMessageTypeToURL : false
        });
        cometD.websocketEnabled = false;
        cometD.handshake(function (reply) {
            if(reply.successful){
                console.log('connected to CometD');
                let subsToEvent = cometD.subscribe('/event/Chat_Message__e',function (chatEvent) {
                    this.handleMessage(component, chatEvent);
                });
                component.set("v.subsCometD", subsToEvent);
            }
        });

 /*       var action = component.get("c.getSessionId");
        action.setCallback(this, function(response) {
            var sessionId = response.getReturnValue();
            var cometd = new window.org.cometd.CometD();
            console.log('cometd : ' + JSON.stringify(cometd));
            cometd.configure({
                url: 'https://force-fun-1627-dev-ed.lightning.force.com/cometd/40.0',
                requestHeaders: { Authorization: 'OAuth ' + sessionId },
                appendMessageTypeToURL : false
            });
            cometd.websocketEnabled = false;
            cometd.handshake($A.getCallback(function(status) {
                if (status.successful) {
                    cometd.subscribe('/event/Chat_Message__e', $A.getCallback(
                        function(message) {
                            console.log(message);
                        }
                    ));
                }
            }));

        });
        $A.enqueueAction(action);*/
    },
    handleMessage : function (component, message) {
        console.log('mess : ' + JSON.stringify(message));
        let agentMessages = component.get("v.agentMessages");
        if(message.data.payload.AgentOrClient__c === 'Agent'){
            agentMessages.push(message.data.payload.Message__c);
            component.set('v.agentMessages', agentMessages);
        }
    }

});