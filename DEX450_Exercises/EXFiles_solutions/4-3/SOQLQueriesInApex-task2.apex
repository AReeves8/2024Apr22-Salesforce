//--------------------------------------------------------------------------------------------
//TASK 2: Retrieve multiple cases.

//TODO: Write an Apex statement that:
//   - Declares a variable whose type is a List of Case sObjects named cases and assign it the value of a SOQL query that
//   - Selects the Id field
//   - From the Case sObject

List<Case> cases = [SELECT Id From Case];
System.debug('Total number of cases: ' + cases.size());
for (Case c : cases) {
    System.debug(c);
}