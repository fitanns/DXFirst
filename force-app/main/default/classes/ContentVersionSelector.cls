/**
 * Created by DmytroPinchuk on 26.09.2019.
 */

public with sharing class ContentVersionSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                ContentVersion.Id,
                ContentVersion.Title

        };
    }
    public Schema.SObjectType getSObjectType() {
        return ContentVersion.sObjectType;
    }

    public List<ContentVersion> selectByContentDocumentId(Set<Id> ids) {
        return (List<ContentVersion>) Database.query(
                newQueryFactory().
                        setCondition('ContentDocumentId IN : ids').
                        toSOQL()

        );
    }
}