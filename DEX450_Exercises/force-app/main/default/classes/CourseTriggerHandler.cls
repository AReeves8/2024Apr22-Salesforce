public with sharing class CourseTriggerHandler {
    
    static final String RETIRED = 'Retired';
    static final String ENROLLED = 'Enrolled';
    static final String SCHEDULED = 'Scheduled';
    static final String CANCELLED = 'Cancelled';
    static final String ERROR_MESSAGE = 'Course has enrolled students';
           
    public static void checkStatus(List<Course__c> triggerNew, Map<Id, Course__c> oldMap, Map<Id, Course__c> newMap)  {
        
        /**
        *  If a Course Status is changed to retired, then we need to
        *  check to see if there are any Course Delivery records marked
        *  as Scheduled and if there is at least one attendee marked
        *  as Enrolled, then the change to retired should not happen 
        *  and an error passed back
        */ 

        
        // Loop through all Course Delivery records to look for attendees
        for ( Course__c course :  triggerNew) {
            if ( oldMap.get(course.Id).Status__c != RETIRED && course.Status__c == RETIRED ) {
                List<Course_Delivery__c> cds = [SELECT Id, Course__c, Status__c, 
                                               (SELECT Status__c FROM Course_Attendees__r
                                                  WHERE Status__c = :ENROLLED) 
                                           FROM Course_Delivery__c
                                           WHERE Course__c = :course.Id];   
                for (Course_Delivery__c cd : cds) {
                    if ( cd.Status__c == 'Scheduled'  && cd.Course_Attendees__r.size() > 0 ) {
                        newMap.get(cd.Course__c).addError(ERROR_MESSAGE);
                    } else {
                        // Change the status of the Course Delivery record to 'Cancelled' 
                        cd.Status__c = CANCELLED;
                        update cd;   
                    }    
                }                               
            } 
        }

    }
}