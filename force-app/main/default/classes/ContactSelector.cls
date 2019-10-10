/**
 * Created by DmytroPinchuk on 10.10.2019.
 */

public with sharing class ContactSelector extends QueryBuilder{
    public List<Contact> getContactByAccountId(Set<Id> accountsIds) {
        return (List<Contact>) new QueryBuilder(Contact.class)
                .addField('Id')
                .addField('MobilePhone')
                .addConditions().add(new QueryBuilder.InCondition('AccountId').inCollection(accountsIds)).endConditions()
                .toList();
    }
}