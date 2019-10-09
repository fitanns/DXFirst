/**
 * Created by DmytroPinchuk on 09.10.2019.
 */

public with sharing class SubjectInfoFactory {
    public SubjectInterface getMathInfo() {
        ManageSubjectsInfoSelector selector = new ManageSubjectsInfoSelector();
        List<ManageSubjectsInfo__mdt> manageSubjectsInfo = selector.getManageSubjectsInfo('MathInfoService');
        return (SubjectInterface) Type.forName(manageSubjectsInfo[0].SubjectService__c).newInstance();
    }

    public SubjectInterface getPhizInfo() {
        ManageSubjectsInfoSelector selector = new ManageSubjectsInfoSelector();
        List<ManageSubjectsInfo__mdt> manageSubjectsInfo = selector.getManageSubjectsInfo('PhizInfoService');
        return (SubjectInterface) Type.forName(manageSubjectsInfo[0].SubjectService__c).newInstance();
    }
}
