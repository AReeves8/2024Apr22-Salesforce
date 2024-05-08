//TODO #1 - Annotate the class as a RestRource. The urlMapping should be /Candidate/JobApp.

global class CandidateKeyRESTService {

    //TODO #2 - Annotate the method to process POST requests.

    global static Boolean submitEmployeeReferral(String posId, Candidate__c c){
        // this webservice receives a position Id, JobApplication and Candidate and creates the
        // JobApplication and optionally the Candidate, depending on whether or not it already exists
        
        System.debug('submitEmployeeReferral BEGIN');
        
        // first we check to see if we'll need to create a candidate or not
        boolean cCreate = true; // default to true
        System.debug('Querying for existing candidate record...');
        if (c.Email__c != null){
            String uKey = c.Last_Name__c.toLowerCase() + c.Email__c.toLowerCase();
            // query to find dupes
            if ([select count() from Candidate__c where unique_key__c = :uKey] >= 1) {
                cCreate=false;
                // set c to be the dupe candidate so we can get the Id value of the candidate later
                c = [select Id from Candidate__c where unique_key__c = :uKey limit 1];
                System.debug('Existing record found: ' + c.Id);
            }
        }
        
        // create a boolean to catch any errors in case we need to rollback
        boolean err = false;
        
        // create the candidate if necessary based off previous check
        if (cCreate){
            System.debug('No record found, creating Candidate...');
            try{
                insert c;
                System.debug('Candidate record created successfully with id: ' + c.Id);
            } catch (System.DmlException e) {
                //update our err flag
                err = true;
                System.debug('error bulk inserting new candidate record');
                for (Integer k = 0; k < e.getNumDml(); k++) {
                    // Process exception here
                    System.debug(e.getDmlMessage(k));
                }
            } catch (Exception ex) {
                System.debug('An error occurred while inserting the candidate record: ' + ex.getMessage());
            }
        }
        
        // if there has been no error then create the Job Application
        if (!err){
            System.debug('Creating the Application...');
            Job_Application__c j = new Job_Application__c();
            j.Status__c = 'Open';
            j.Stage__c = 'New';
            j.Position__c = posId;
            j.Candidate__c = c.Id;
            
            try{
                insert j;
                System.debug('Application record created successfully with id: ' + j.Id);
            } catch (System.DmlException e) {
                System.debug('error bulk inserting new job application');
                for (Integer k = 0; k < e.getNumDml(); k++) {
                    // Process exception here
                    System.debug(e.getDmlMessage(k));
                }
            } catch (Exception ex) {
                System.debug('An error occurred while inserting the application record: ' + ex.getMessage());
            }
        }
        
        System.debug('submitEmployeeReferral END');
        
        // check for errors and return the success flag
        if (!err) {
            return true;
        } else {
        //  further error handling here
            return false;
        }   
    }
}