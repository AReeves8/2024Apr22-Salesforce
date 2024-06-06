public with sharing class AccountResourceHandler {
    public AccountResourceHandler() {

    }

    // returns all accounts
    public static List<Account> getAccounts() {
        return [SELECT Id, Name FROM Account];
    }

    // returns an account with a specific ID
    public static List<Account> getAccountById(String accountId) {
        return [SELECT Id, Name FROM Account WHERE Id = :accountId];
    }

    // returns an account with a specific ID and it's contacts
    public static List<Account> getAccountContactsByAccountId(String accountId) {
        return [SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts) FROM Account WHERE Id = :accountId];
    }

    // creates an account record with the provided information
    public static Account createAccount(String name, String phone, Decimal annualRevenue) {
        Account account = new Account(Name = name, Phone = phone, AnnualRevenue = annualRevenue);
        insert account;
        return account;
    }

    // finds an account with the provided id and updates it with the provided information
    public static void updateAccount(String id, String name, String phone, Decimal annualRevenue) {

        Account acc = [SELECT Id FROM Account WHERE Id = :id];
        acc.Name = name;
        acc.Phone = phone;
        acc.AnnualRevenue = annualRevenue;
        update acc;
    }

    // finds an account with the provided id and deletes it
    public static void deleteAccount(String id) {
        Account acc = [SELECT Id FROM Account WHERE Id = :id];
        delete acc;
    }
}