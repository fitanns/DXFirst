/**
 * Created by DmytroPinchuk on 23.09.2019.
 */

public with sharing class AgentChatterController {

    @AuraEnabled
    public static void publishMessage(Chat_Message__e message) {
        PublishPlatformEventService publish = new PublishPlatformEventService();
        publish.publishMessage(message);
    }
}