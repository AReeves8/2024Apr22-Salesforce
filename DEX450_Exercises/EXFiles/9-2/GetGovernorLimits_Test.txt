@isTest
private without sharing class GetGovernorLimits_Test {

    @TestSetup
    static void makeData() {

        // Create 2 Accounts each with 3 Contacts as test data
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Account 1'));
        accounts.add(new Account(Name='Account 2'));
        insert accounts;

        List<Contact> contacts = new List<Contact>();
        for (Account acc : accounts) {
            contacts.add(new Contact(LastName=acc.Name + ' Contact 1', AccountId=acc.Id));
            contacts.add(new Contact(LastName=acc.Name + ' Contact 2', AccountId=acc.Id));
            contacts.add(new Contact(LastName=acc.Name + ' Contact 3', AccountId=acc.Id));
        }
        insert contacts;
    }

    @isTest
    private static void testQueryGovLimit() {
        List<String> requests = new List<String>();
        List<GetGovernorLimits.LimitsResult> results = new List<GetGovernorLimits.LimitsResult>();

        // Load the limit name
        String req = 'QUERIES';
        requests.add(req);

        // Do the test (don't use startTest/stopTest as we are checking limit usage)
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account];
        results = GetGovernorLimits.getLimit(requests);

        // Check to see what we got
        System.assertEquals(1, results[0].limitUsage,'ERROR Expected 1 query usage');
    }

    @isTest
    private static void testQueryRowGovLimit() {
        List<String> requests = new List<String>();
        List<GetGovernorLimits.LimitsResult> results = new List<GetGovernorLimits.LimitsResult>();

        // Load the limit name
        String req = 'QUERYROWS';
        requests.add(req);

        // Do the test (don't use startTest/stopTest as we are checking limit usage)
        List<Account> accounts = [SELECT Id, (SELECT Id FROM Contacts) FROM Account];
        results = GetGovernorLimits.getLimit(requests);

        // Check to see what we got
        System.assertEquals(8, results[0].limitUsage,'ERROR Expected 8 query row usage');
    }    

    @isTest
    private static void testDMLGovLimit() {
        List<String> requests = new List<String>();
        List<GetGovernorLimits.LimitsResult> results = new List<GetGovernorLimits.LimitsResult>();

        // Load the limit name
        String req = 'DMLSTATEMENTS';
        requests.add(req);

        // Do the test (don't use startTest/stopTest as we are checking limit usage)
        results = GetGovernorLimits.getLimit(requests);

        // Check to see what we got
        System.assertEquals(2, results[0].limitUsage,'ERROR Expected 2 DML statement usage');
    }

    @isTest
    private static void testDMLRowsGovLimit() {
        List<String> requests = new List<String>();
        List<GetGovernorLimits.LimitsResult> results = new List<GetGovernorLimits.LimitsResult>();

        // Load the limit name
        String req = 'DMLROWS';
        requests.add(req);

        // Do the test (don't use startTest/stopTest as we are checking limit usage)
        results = GetGovernorLimits.getLimit(requests);

        // Check to see what we got
        System.assertEquals(8, results[0].limitUsage,'ERROR Expected 8 DML row usage');
    }

    @isTest
    private static void testInvalidLimit() {
        List<String> requests = new List<String>();
        List<GetGovernorLimits.LimitsResult> results = new List<GetGovernorLimits.LimitsResult>();

        // Load the limit name
        String req = 'INVALID';
        requests.add(req);

        // Do the test (don't use startTest/stopTest as we are checking limit usage)
        results = GetGovernorLimits.getLimit(requests);

        // Check to see what we got
        System.assertEquals(-1, results[0].limitUsage,'ERROR Invalid limit name');
    }
}