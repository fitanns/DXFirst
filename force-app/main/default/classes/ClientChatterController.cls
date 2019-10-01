/**
 * Created by DmytroPinchuk on 23.09.2019.
 */

public with sharing class ClientChatterController {

    @AuraEnabled
    public static void publishClientMessage(Chat_Message__e message) {
        PublishPlatformEventService publish = new PublishPlatformEventService();
        publish.publishMessage(message);
    }

    @AuraEnabled
    public static String getSessionId(){
        return UserInfo.getSessionId();
    }

}