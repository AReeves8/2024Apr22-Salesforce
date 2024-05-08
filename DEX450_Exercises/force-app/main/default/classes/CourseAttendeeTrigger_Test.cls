@isTest
public class CourseAttendeeTrigger_Test {

    @testSetup
    static void setupData(){

        List<Account> testAccounts = LoadDataTestFactory.loadAccounts();
        List<Contact> testContacts = LoadDataTestFactory.loadContacts();
        List<Certification__c> testCerts = LoadDataTestFactory.loadCertifications();
        List<Course__c> testCourses = LoadDataTestFactory.loadCourses();
        List<User> testUsers = LoadDataTestFactory.createUsers();
        List<Course_Delivery__c> testCourseDeliveries = LoadDataTestFactory.loadCourseDeliveries();

    }


    @isTest
    public static void verifyBulkAttendees() {

         // Get first Course Delivery Record that is 'Scheduled'
        Course_Delivery__c courseDelivery = [SELECT Id, Name FROM Course_Delivery__c WHERE Status__c = 'Scheduled' LIMIT 1][0];

        // Get first Technician Student that is Active
        Id techRecId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Technician').getRecordTypeId();
        Contact student = [SELECT Id, Name FROM Contact WHERE Status__c = 'Active' AND RecordTypeId = :techRecId LIMIT 1][0];

        Test.startTest();
        // Create several new Enrolled Course Attendee recs
        List<Course_Attendee__c> courseAttendees = new List<Course_Attendee__c>();
        for (Integer i=0; i < 205; i++) {
            Course_Attendee__c courseAttendee = new Course_Attendee__c(
                    Course_Delivery__c=courseDelivery.Id,
                    Status__c='Enrolled',
                    Student__c=student.Id
            );
            courseAttendees.add(courseAttendee);
        }
        insert courseAttendees;
        Test.stopTest();

        // Verify that the number of enrolled attendees equals the number of new enrollees
        // assigned to the assigned task
        List<Course_Attendee__c> enrolledAttendees = [SELECT id FROM Course_Attendee__c WHERE status__c='Enrolled'];
        Integer countOfAttendeesForTasks = enrolledAttendees.size();
        List<Task> taskList = [SELECT id, subject FROM Task WHERE Subject LIKE 'Add%new Enrollees to LMS'];

        Integer subjectEnrolleeTotal = 0;
        for (Task t: taskList) {
            String numberOfItems = t.subject.remove('Add ').remove(' new Enrollees to LMS');
            Integer subjectEnrolleeCount = Integer.valueOf(numberOfItems);
            subjectEnrolleeTotal+= subjectEnrolleeCount;
        }
        System.debug('verifyBulkAttendees - countOfAttendeesForTasks: ' + countOfAttendeesForTasks);
        System.assertEquals(countOfAttendeesForTasks, subjectEnrolleeTotal);

    }


}