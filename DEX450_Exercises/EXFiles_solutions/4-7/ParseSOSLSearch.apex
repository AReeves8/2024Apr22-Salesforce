// Establish search criteria
String searchString = 'Frank';

// Search across objects for the search criteria
List<List<sObject>> searchResults = [FIND :searchString RETURNING Contact(FirstName, LastName), User(FirstName, LastName)];

/** TODO #1: Declare a variable whose type is a List of Contact sObjects
 * 	named resultContacts and assign to it to the position zero result 
 *	returned from the SOSL search that initialized the searchResults property.
 */ 
List<Contact> resultContacts = searchResults[0];

/** TODO #2: Create a for-loop with an iterator of type Contact named  
 *           resultContact that iterates over the resultContacts variable. 
 *           Within the loop, call the debug method of the System class  
 *           three times to print out the following:
 *             -- the Id for the resultContact
 *             -- the first name of the resultContact
 *             -- the last name of the resultContact
 */
for (Contact resultContact : resultContacts) {
    System.debug('\nresultContact Id = ' + resultContact.id);
    System.debug('First Name is      ' + resultContact.FirstName);
    System.debug('Last Name is       ' + resultContact.LastName);
}

/** TODO #3: Declare a variable whose type is a list of User sObjects 
 *	called resultUsers and assign it to the position one result returned 
 *	from the SOSL search above.
 */
List<User> resultUsers = searchResults[1];

for (User resultUser : resultUsers) {
    System.debug('\nThe resultUser id is: ' + resultUser.id);
    System.debug('The User first name is: ' + resultUser.firstname);
    System.debug('The User last name is: ' + resultUser.lastname);
}

// OPTIONAL TODO #4: Review this alternative solution that processes 
//  contacts and users using the same loop
/*
// Alternative solution
for (List<sObject> resultList :[FIND '{Frank}' RETURNING Contact(FirstName, LastName), User(FirstName, LastName)]) {
    System.debug('\n\nCurrently Processing ' + resultList[0].getSObjectType());
    for (sObject record :resultList) {
        System.debug('\nThe record id is: ' + record.get('Id'));
        System.debug('The first name is: ' + record.get('FirstName'));
        System.debug('The last name is: ' + record.get('LastName'));
    }
}
*/