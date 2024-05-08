//  TASK 1: Attempt to run the following Apex code which uses a bound
//          variable to specify filter criteria.  Observe that it causes 
//          an error. We will work around this error in our next
//          task - for now just confirm that the error occurs.
//--------------------------------------------------------------------------------------------
Integer numDays = 10;
List<Case> cases = [SELECT Id, Subject, CreatedDate
                    FROM Case
                    WHERE CreatedDate = LAST_N_DAYS:numDays];
System.debug(cases);
