//--------------------------------------------------------------------------------------------
//TASK 1: Retrieve a single case.

//TODO: Write an Apex statement that:
//       - Declares a variable of type Case named aCase and assign it the value of a SOQL query that
//         - Selects the Subject field
//         - From the Case sObject
//         - Where the value of the Id field of the Case sObject equals the Id of a Case record you find in the Salesforce UI.

Case aCase = [SELECT Subject FROM Case WHERE Id='5001400000pWq3BAAS'];
System.debug(aCase);
