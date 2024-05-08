@isTest
public class LoadDataTestFactory {
    
    public static List<Account> loadAccounts() {
        // We need to assign the Account to the correct recordtype after it has been loaded
        List<Account> initialAccounts = Test.loadData(Account.sObjectType, 'TestAccounts');
        for (Account a: initialAccounts) {
            if (a.Name.startsWith('SV')) {
                //Service Vendor recordType
                a.recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Service Vendor').getRecordTypeId();             
            } else {
                //Customer recordType
                a.recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
            }       
        }
        update initialAccounts;
        return initialAccounts;
    }
    
    public static List<Contact> loadContacts() {
        // We need to assign the Contact to the correct recordtype after it has been loaded
        List<Contact> initialContacts = Test.loadData(Contact.sObjectType, 'TestContacts');
        for (Contact c: initialContacts) {
            if (c.LastName.startsWith('T')) {
                //Service Vendor recordType
                c.recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Technician').getRecordTypeId();             
            } else {
                //Standard recordType
                c.recordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Standard').getRecordTypeId();
            }       
        }
        update initialContacts;
        return initialContacts;
    }
    
    public static List<Certification__c> loadCertifications() {
        return Test.loadData(Certification__c.sObjectType, 'TestCertifications');
    }
    
    public static List<Course__c> loadCourses() {
        return Test.loadData(Course__c.sObjectType, 'TestCourses');
    }
    
    public static List<Course_Delivery__c> loadCourseDeliveries() {
        // Need to assign the Course Deliveries to an Instructor user after they have been loaded
        List<Course_Delivery__c> initialDeliveries = Test.loadData(Course_Delivery__c.sObjectType, 'TestCourseDeliveries');
        User instructor = [ select Id from User where Is_Instructor__c = true LIMIT 1 ];
        for (Course_Delivery__c cd: initialDeliveries) {
            cd.Instructor__c = instructor.Id;
        }
        update initialDeliveries;
        return initialDeliveries;
    }
    
    public static List<Course_Attendee__c> loadCourseAttendees() {
        return Test.loadData(Course_Attendee__c.sObjectType, 'TestCourseAttendees');
    }
    
    public static List<User> createUsers() {
        // We had problems loading the User data from Static Resource files and ended up having to create
        // them manually

        Id instructorProfileId = [SELECT Id FROM Profile WHERE Name = 'Instructor User' LIMIT 1].Id;
        Id trainingProfileId = [SELECT Id FROM Profile WHERE Name = 'Training User' LIMIT 1].Id;

        List<User> users = new List<User>();
        User trainingCoordinator = new User(Username='nsanchez@example.com',
                                            FirstName='Nicki', LastName=' Sanchez',
                                            email='nsanchez@example.com',
                                            alias='nsanchez',
                                            CommunityNickname='nsanchez',
                                            TimeZoneSidKey='America/Los_Angeles',
                                            LocaleSidKey='en_US', 
                                            EmailEncodingKey='UTF-8',
                                            ProfileId=trainingProfileId, 
                                            LanguageLocaleKey='en_US'
                                           );
        users.add(trainingCoordinator);
        User instructor = new User(Username='mholmes@example.com',
                                            FirstName='Minnie', LastName='Holmes',
                                            email='mholmes@example.com',
                                            alias='mholmes',
                                            CommunityNickname='mholmes',
                                            TimeZoneSidKey='America/Los_Angeles',
                                            LocaleSidKey='en_US', 
                                            EmailEncodingKey='UTF-8',
                                            ProfileId=instructorProfileId, 
                                            Is_Instructor__c=true,
                                            LanguageLocaleKey='en_US'
                                           );
        users.add(instructor);
        return users;
    }
    
    public static Holiday createHoliday(){
        Holiday newYearsEve = new Holiday(ActivityDate = 
                              Date.newInstance(Date.today().year(), 12, 31), 
                              Name = 'New Years Eve');
        insert newYearsEve;
        
        return newYearsEve;
    }
}