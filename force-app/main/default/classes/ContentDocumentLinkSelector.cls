/**
 * Created by DmytroPinchuk on 26.09.2019.
 */

public with sharing class ContentDocumentLinkSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
                ContentDocumentLink.ContentDocumentId

        };
    }
    public Schema.SObjectType getSObjectType() {
        return ContentDocumentLink.sObjectType;
    }

    public List<ContentDocumentLink> selectBySubjectId(Id ids) {
        return (List<ContentDocumentLink>) Database.query(
                newQueryFactory().
                        setCondition('LinkedEntityId = : ids').
                        toSOQL()

        );
    }
}