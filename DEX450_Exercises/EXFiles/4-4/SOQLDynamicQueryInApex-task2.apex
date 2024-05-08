//  TASK 2: Work around the issues you faced in task 1 by using Use Database.query() 
//          to run a query that is dynamically built using a string
//--------------------------------------------------------------------------------------------

//  SPECIFICATION FOR WHERE CLAUSE
//      The WHERE clause you are constructing should determine if the
//      CreatedDate field of the Case sObject occurred within the last N days.  
//      The value of N comes from the hardcoded Integer variable numDays.
//      To do this, assign the whereClause variable a value 
//      composed of 2 parts concatenated together:
//      -  a String literal that includes the WHERE keyword followed by 
//         the start of the expression that checks if the value of the 
//         CreatedDate field equals the value of the LAST_N_DAYS
//         date literal, up to and including the colon
//      - the variable numDays 

Integer numDays = 10;
String selectClause = 'SELECT Id, Subject, CreatedDate ';
String fromClause = 'FROM Case ';

//TODO: fill in the whereClause variable according to the spec
String whereClause = 'PLEASE_FILL_ME_IN';  

String fullQuery = selectClause + fromClause + whereClause;
List<Case> caselist = Database.query(fullQuery);

System.debug('\n\nTotal number of cases: ' + caseList.size());
for (Case c : caseList) {
    System.debug(c);
}
