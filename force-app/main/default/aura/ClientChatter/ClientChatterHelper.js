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
                this.connectCometD(component,result);
            },
            error => {
            }
        );
    },
    connectCometD: function (component, sessionId) {
        let cometd = new window.org.cometd.CometD();
        console.log('ses : ' + sessionId);
        cometd.configure({
            url: window.location.protocol + '//' + window.location.hostname + '/cometd/41.0/',
            requestHeaders: {Authorization: 'OAuth ' + sessionId},
            appendMessageTypeToURL: false
        });
        cometd.websocketEnabled = false;
        component.set('v.cometd', cometd);

        cometd.handshake($A.getCallback(function (status) {
            if (status.successful) {
                let eventName = component.get("v.eventName");
                var subscription = cometd.subscribe(eventName, $A.getCallback(function (message) {
                        this.handleMessage(component, message.data.payload);
                    }
                ));
                component.set('v.subsCometD', subscription);
            } else {
                console.error('streaming component: ' + JSON.stringify(status));
            }
        }));

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
    handleMessage: function (component, message) {
        console.log('mess : ' + JSON.stringify(message));
        let agentMessages = component.get("v.agentMessages");
        if (message.AgentOrClient__c === 'Agent') {
            agentMessages.push(message.Message__c);
            component.set('v.agentMessages', agentMessages);
        }
    }

});