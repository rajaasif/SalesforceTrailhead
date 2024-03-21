Schema.SObjectType typsfe=Schema.getGlobalDescribe().get('account');
Schema.DescribeSObjectResult result=typsfe.getDescribe();
Map<String,SObjectField> fieldsMap=result.fields.getMap();
Schema.DescribeFieldResult field=fieldsMap.get('accountsource').getDescribe();
List<Schema.PicklistEntry> picklist=field.getPicklistValues();
System.debug(picklist);
for(Schema.PicklistEntry entry:picklist){
    System.debug(entry.getValue() + ':' + entry.getLabel());
}
System.debug('where like \'%'+' aaaaaaa '+'%\'');
System.debug('\'\'\'');