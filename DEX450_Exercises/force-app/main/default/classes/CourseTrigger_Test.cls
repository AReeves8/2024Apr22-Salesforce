@isTest
public class CourseTrigger_Test {

    // Variables used in test
    static final String RETIRED = 'Retired';
    static final String TECHNICIAN = 'Technician';
    static final String ENROLLED = 'Enrolled';
    static final String SCHEDULED = 'Scheduled';
    static final String CANCELLED = 'Cancelled';
    static final String DELIVERED = 'Delivered';

    @testSetup
    static void setupData(){

        List<Account> testAccounts = LoadDataTestFactory.loadAccounts();
        List<Contact> testContacts = LoadDataTestFactory.loadContacts();
        List<Certification__c> testCerts = LoadDataTestFactory.loadCertifications();
        List<Course__c> testCourses = LoadDataTestFactory.loadCourses();
        List<User> testUsers = LoadDataTestFactory.createUsers();
        List<Course_Delivery__c> testCourseDeliveries = LoadDataTestFactory.loadCourseDeliveries();
        List<Course_Attendee__c> testCourseAttendes = LoadDataTestFactory.loadCourseAttendees();

    }

    @isTest
    static void checkStatusTestPreventRetirement(){
        // Look at Courses which are active
        List<Course__c> activeToRetired = [SELECT Status__c FROM Course__c WHERE Status__c != :RETIRED];
        // In these active courses, look for enrolled students where Course_Delivery__c is Scheduled
        List<Course_Delivery__c> scheduledDeliveries = [SELECT Status__c, (SELECT Status__c FROM Course_Attendees__r WHERE Status__c = :ENROLLED)
                                                          FROM Course_Delivery__c
                                                         WHERE Status__c = :SCHEDULED
                                                           AND Course__c IN :activeToRetired];

        // We want to make sure we have actual data to work with (not firing blanks)
        System.assertNotEquals(0, activeToRetired.size());
        System.assertNotEquals(0, scheduledDeliveries.size());

        // Change everything to retired
        for(Course__c retire : activeToRetired){
            retire.Status__c = RETIRED;
        }
        Database.SaveResult[] lsr = Database.update(activeToRetired, false);
        for(Database.SaveResult sr : lsr){
            if(!sr.isSuccess()){
                System.assertEquals('Course has enrolled students', sr.getErrors()[0].getMessage());
            }
        }
    }
/*
    //@isTest
    static void checkStatusTestCancelDelivery(){
        // If no students are enrolled, course is OK to retire, unless it has already been delivered.
        // Also, Course_Delivery__c should be cancelled by trigger where there are no enrolled students.
        List<Course__c> activeToRetired = [SELECT Status__c FROM Course__c WHERE Status__c != :RETIRED];
        List<Course_Delivery__c> nonCancelledDeliveries = [SELECT Status__c, (SELECT Status__c FROM Course_Attendees__r WHERE Status__c = :ENROLLED)
                                                             FROM Course_Delivery__c
                                                            WHERE Status__c IN (:DELIVERED, :SCHEDULED)
                                                              AND Course__c IN :activeToRetired];
        List<Course_Attendee__c> unEnroll = new List<Course_Attendee__c>();
        List<Course_Delivery__c> deliveredDeliveries = new List<Course_Delivery__c>();
        List<Course_Delivery__c> scheduledDeliveries = new List<Course_Delivery__c>();

        // We want to make sure we have actual data to work with
        System.assertNotEquals(0, activeToRetired.size());
        System.assertNotEquals(0, nonCancelledDeliveries.size());

        // Collect Course_Delivery__c according to status. If delivered, we'll check later that it stayed delivered
        // Else if scheduled, should be cancelled
        for(Course_Delivery__c cd : nonCancelledDeliveries){
            if(cd.Status__c == DELIVERED){
                deliveredDeliveries.add(cd);
            } else {
                scheduledDeliveries.add(cd);
            }
            // Un-enroll all students otherwise we won't be allowed to retire the course
            for(Course_Attendee__c ca : cd.Course_Attendees__r){
                if(ca.Status__c == ENROLLED){
                    ca.Status__c = '';
                    unEnroll.add(ca);
                }
            }
        }
        update unEnroll;

        // Change status of course to retired
        for(Course__c retire : activeToRetired){
            retire.Status__c = RETIRED;
        }
        update activeToRetired;

        // Scheduled deliveries should be cancelled
        List<Course_Delivery__c> cancelledDeliveries = [SELECT Id, Status__c FROM Course_Delivery__c WHERE id IN :scheduledDeliveries];
        for(Course_Delivery__c cancelledDelivery : cancelledDeliveries){
            System.assertEquals(CANCELLED, cancelledDelivery.Status__c);
        }

        // Delivered deliveries should remain delivered
        List<Course_Delivery__c> notCancelledDeliveries = [SELECT Id, Status__c FROM Course_Delivery__c WHERE id IN :deliveredDeliveries];
        for(Course_Delivery__c deliveredDelivery : notCancelledDeliveries){
            System.assertEquals(DELIVERED, deliveredDelivery.Status__c);
        }
    }
  */
}