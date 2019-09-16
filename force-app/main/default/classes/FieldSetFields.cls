/**
 * Created by DmytroPinchuk on 13.09.2019.
 */

public with sharing class FieldSetFields {

    @AuraEnabled
    public Boolean DBRequired { get;set; }

    @AuraEnabled
    public String FieldAPIName { get;set; }

    @AuraEnabled
    public String Label { get;set; }

    @AuraEnabled
    public Boolean Required { get;set; }

    @AuraEnabled
    public String Type { get; set; }

    public FieldSetFields(Schema.FieldSetMember fieldSetMember) {
        this.DBRequired = fieldSetMember.DBRequired;
        this.FieldAPIName = fieldSetMember.fieldPath;
        this.Label = fieldSetMember.label;
        this.Required = fieldSetMember.required;
        this.Type = String.valueOf(fieldSetMember.getType());
    }

    public FieldSetFields(Boolean DBRequired) {
        this.DBRequired = DBRequired;
    }

}
