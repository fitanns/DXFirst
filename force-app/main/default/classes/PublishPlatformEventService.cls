/**
 * Created by DmytroPinchuk on 26.09.2019.
 */

public with sharing class PublishPlatformEventService {
    public void publishMessage(SObject message){
        Database.SaveResult sr = EventBus.publish(message);
        if (sr.isSuccess()) {
            System.debug('Success publish message');
        } else {
            for (Database.Error errors : sr.getErrors()) {
                System.debug(errors.getStatusCode() + ' - ' + errors.getMessage());
            }
        }
    }
}