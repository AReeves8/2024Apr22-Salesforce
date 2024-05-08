//--------------------------------------------------------------------------------------------
//  TASK 2:  Write Apex to create a for loop with an iterator of type List 
//           whose elements are of class Contact named cList that iterates 
//           over the SOQL query you completed in Task 1.  Within the SOQL 
//           loop create a second for loop with an iterator of type Contact 
//           named aContact, that iterates over the outer loop's cList variable.  
//           Within the inner loop use a System.debug command to output the
//           information you have retrieved.
//  Example of output: 
//    "Contact: Erica Neumann is related to the following Account: Acme Corp"
//--------------------------------------------------------------------------------------------

for ( /* TODO: iterate over SOQL query of Contacts from Task 1 */ ) {
    for (/* TODO: iterate over the the loop variable from outer loop */ ) {
        //TODO: make the statement below dynamic
        System.debug('Contact: Erica Neumann is related to the following Account: Acme Corp')
    }
}
