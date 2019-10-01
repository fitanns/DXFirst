/**
 * Created by DmytroPinchuk on 24.09.2019.
 */

({
    onInit: function (component, event, helper) {
        let channelName = '/event/' + component.get('v.streamingChannel');
        component.set('v.channelName', channelName);
        console.log('chn' + channelName);
        const empApi = component.find('empApi');
        console.log(empApi);
        empApi.onError($A.getCallback(error => {
            console.log('EmpApi error : ' + error);
        }));
    },
 /*       empApi.subscribe(channel, replayId, $A.getCallback(eventReceived => {
            console.log('Received event ', JSON.stringify(eventReceived));
        }))
            .then(subscription => {
                console.log('Subscription : ' + subscription.channel);
                component.set('v.subscription', subscription);
            });*/

    subscribe: function (component, event, helper) {
        const empApi = component.find('empApi');
        const channel = component.get('v.channelName');
        const replayId = -1;
        const callback = function (message) {
            console.log('Event Received : ' + JSON.stringify(message));
            helper.onReceiveNotification(component, message);
        };
        empApi.subscribe(channel, replayId, $A.getCallback(callback)).then($A.getCallback(function (newSubscription) {
            console.log('Subscribed to channel ' + channel);
            component.set('v.subscription', newSubscription);
        }));
/*        const callback = function (message) {
            console.log('Event Received : ' + JSON.stringify(message));
            helper.onReceiveNotification(component, message);
        };*/

 /*       empApi.subscribe(channel, replayId, $A.getCallback(eventReceived => {
            console.log('Message : ' + eventReceived.data.payload.Message__c);
            console.log('AgentOrClient : ' + eventReceived.data.payload.AgentOrClient__c);
            console.log('Received event : ', JSON.stringify(eventReceived));
        }))*/
    },
    unsubscribe: function (component, event, helper) {
        const empApi = component.find('empApi');
        const subscription = component.get('v.subscription');
        if (subscription !== null) {
            empApi.unsubscribe(subscription, $A.getCallback(unsubscribed => {
                console.log('Unsubscribed channel : ' + unsubscribed.subscription);
                component.set('v.subscription', null);
            }));
        }
    }
});