/**
 * Created by DmytroPinchuk on 09.10.2019.
 */

public with sharing class UpdateLeadsBySubjectData implements Schedulable {

    public void execute(SchedulableContext param1) {
        LeadsBySubjectsBatch batch = new LeadsBySubjectsBatch();
        Id batchId = Database.executeBatch(batch);
    }
}