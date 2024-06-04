public without sharing class DynamicObjectSearchController {
    public DynamicObjectSearchController() {

    }


    @AuraEnabled(cacheable=true)
    public static List<String> getObjectFields(String objectName){
    
        try {
            
            // we are getting metadata for the object being passed in
            SObjectType objectType = Schema.getGlobalDescribe().get(objectName);

            // getting all fields and their metadata as a map
            Map<String, Schema.SObjectField> objectFields = objectType.getDescribe().fields.getMap();

            // getting field names from map
            List<String> fieldList = new List<String>();
            for(String fieldName : objectFields.keySet()){

                // fieldname contains the name of the field in all lowercase
                // pulling field name out of the map will be better formatted
                fieldList.add(String.valueOf(objectFields.get(fieldName)));
            }

            return fieldList;

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }


    /**
     * Takes in a string containing the Name of an object and a list of Field Names as strings. Formats the fields and object name into a SOQL query. 
     * The results of the query are returned. 
     */
    @AuraEnabled(cacheable=true)
    public static List<SObject> getRecords(String objectName, List<String> fieldNames) {
        
        // formatting fields for SELECT clause
        String selectClause = 'SELECT ';
        for(String field : fieldNames) {
            selectClause += (field + ', ');
        }
        selectClause = selectClause.removeEnd(', ');

        // putting the clauses together and querying with the result string
        String fromClause = ' FROM ' + objectName;
        String fullQuery = selectClause + fromClause;
        return Database.query(fullQuery);
    }
}