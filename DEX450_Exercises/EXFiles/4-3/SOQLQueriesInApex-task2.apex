//--------------------------------------------------------------------------------------------
//TASK 2: Retrieve multiple cases.

//TODO: Write an Apex statement that:
//   - Declares a variable whose type is a List of Case sObjects named 
//      caseList and assign it the value of a SOQL query that
//   - Selects the Id field
//   - From the Case sObject


System.debug('\n\nTotal number of cases: ' + caseList.size());
for (Case c : caseList) {
    System.debug(c);
}