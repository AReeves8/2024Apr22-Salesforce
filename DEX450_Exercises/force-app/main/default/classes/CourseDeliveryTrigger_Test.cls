@isTest
private class CourseDeliveryTrigger_Test {

    static final String ACTIVE = 'Active';
    static final String SCHEDULED = 'Scheduled';
    
    // Setup test data
    @testSetup static void setupData(){
     
        User thisUser = [ select Id from User where Id = :UserInfo.getUserId() ];
        System.runAs (thisUser){
            List<Account> testAccounts = LoadDataTestFactory.loadAccounts();
            List<Contact> testContacts = LoadDataTestFactory.loadContacts();
            List<Certification__c> testCerts = LoadDataTestFactory.loadCertifications();
            List<Course__c> testCourses = LoadDataTestFactory.loadCourses();
            Holiday newYearsEve = LoadDataTestFactory.createHoliday();
            List<Course_Delivery__c> testCourseDeliveries = LoadDataTestFactory.loadCourseDeliveries();
        }
    }
    
    @isTest
    static void insertCourseDeliverySuccess() {
        
        // Get the first Active Course
        List<Course__c> activeCourses = [SELECT Id, Name 
                                         FROM Course__c 
                                         WHERE Status__c = :ACTIVE LIMIT 1];
        Course__c course = activeCourses[0];
                
        Test.startTest();
        
        // Create a new Course Delivery record with a Start Date of 9/1/YYYY
        Course_Delivery__c courseDelivery = new Course_Delivery__c();
        courseDelivery.Course__c = course.Id;
        courseDelivery.Start_Date__c = Date.newInstance(Date.today().year(), 9, 1);
        
        // Add it to a list of Course Delivery records that will be passed
        // to the Database.insert method
        List<Course_Delivery__c> deliveries = new List<Course_Delivery__c>();
        deliveries.add(courseDelivery);
        Database.SaveResult[] saveResults = Database.insert(deliveries, false);
        
        Test.stopTest();
        
        // Verify that NO errors are passed back
        Integer errorCount = 0;
        for(Database.SaveResult sr : saveResults) {
            if(!sr.isSuccess()) { 
                if (sr.getErrors()[0].getMessage() == 
                    'Course Delivery cannot be scheduled because it starts on a holiday.')
                    ++errorCount;
            }
        }
        System.assertEquals(0, errorCount);
    }
    
    @isTest
    static void insertCourseDeliveryFailure() {
        
        // Get the first Active Course
        List<Course__c> activeCourses = [SELECT Id, Name 
                                         FROM Course__c 
                                         WHERE Status__c = :ACTIVE LIMIT 1];
        Course__c course = activeCourses[0];

        Test.startTest();
        
        // Create a new Course Delivery record with a Start Date of 12/31/YYYY
        Course_Delivery__c courseDelivery = new Course_Delivery__c();
        courseDelivery.Course__c = course.Id;
        courseDelivery.Start_Date__c = Date.newInstance(Date.today().year(), 12, 31);
        
        // Add it to a list of Course Delivery records that will be passed
        // to the Database.insert method
        List<Course_Delivery__c> deliveries = new List<Course_Delivery__c>();
        deliveries.add(courseDelivery);
        Database.SaveResult[] saveResults = Database.insert(deliveries, false);
                
        Test.stopTest();
        
        // Verify that an error was passed back
        Integer errorCount = 0;
        for(Database.SaveResult sr : saveResults) {
            if(!sr.isSuccess()) { 
                if (sr.getErrors()[0].getMessage() == 
                    'Course Delivery cannot be scheduled because it starts on a holiday.')
                    ++errorCount;
            }
        }
        System.assertEquals(1, errorCount);
        
    }
    
    @isTest
    static void updateCourseDeliverySuccess() {
        
        // Get the first Scheduled Course Delivery record.
        // All the Course Delivery Records were inserted in the TestSetup method
        List<Course_Delivery__c> courseDeliveries = [SELECT Id, Name 
                                                     FROM Course_Delivery__c 
                                                     WHERE Status__c = :SCHEDULED LIMIT 1];
        Course_Delivery__c courseDelivery = courseDeliveries[0];
        
        Test.startTest();
        
        // Update the record with a Start Date of 9/1/YYYY
        courseDelivery.Start_Date__c = Date.newInstance(Date.today().year(), 9, 1);
        
        // Add it to a list of Course Delivery records that will be passed
        // to the Database.update method
        List<Course_Delivery__c> deliveries = new List<Course_Delivery__c>();
        deliveries.add(courseDelivery);
        Database.SaveResult[] saveResults = Database.update(deliveries, false);
        
        Test.stopTest();
        
        // Verify that NO errors are passed back
        Integer errorCount = 0;
        for(Database.SaveResult sr : saveResults) {
            if(!sr.isSuccess()) { 
                if (sr.getErrors()[0].getMessage() == 
                    'Course Delivery cannot be scheduled because it starts on a holiday.')
                    ++errorCount;
            }
        }
        System.assertEquals(0, errorCount);
        
    }
    
    @isTest
    static void updateCourseDeliveryFailure() {
    
        // Get the first Scheduled Course Delivery record
        // All the Course Delivery Records were inserted in the TestSetup method
        List<Course_Delivery__c> courseDeliveries = [SELECT Id, Name 
                                                     FROM Course_Delivery__c 
                                                     WHERE Status__c = :SCHEDULED LIMIT 1];
        Course_Delivery__c courseDelivery = courseDeliveries[0];
        
        Test.startTest();
        
        // Update the record with a Start Date of 12/31/YYYY
        courseDelivery.Start_Date__c = Date.newInstance(Date.today().year(), 12, 31);
        
        // Add it to a list of Course Delivery records that will be passed
        // to the Database.update method
        List<Course_Delivery__c> deliveries = new List<Course_Delivery__c>();
        deliveries.add(courseDelivery);
        Database.SaveResult[] saveResults = Database.update(deliveries, false);
        
        Test.stopTest();
        
        // Verify that an error was passed back
        Integer errorCount = 0;
        for(Database.SaveResult sr : saveResults) {
            if(!sr.isSuccess()) { 
                if (sr.getErrors()[0].getMessage() == 
                    'Course Delivery cannot be scheduled because it starts on a holiday.')
                    ++errorCount;
            }
        }
        System.assertEquals(1, errorCount);
    }
}