/**

    EXECUTE ANONYMOUS
        .apex
        no "main" so if you're looking to just run simple code, you do it here
        temporary code you just wanna run once
        no available in prod
            code cannot be directly executed in production by a user

        runs in "User mode"
            user mode means that it respects the data access rules in your org

            "System mode" - ignores data access levels
                most apex is system mode
        

        .cls - apex class
            more permanent option

 */

// Apex is OOP

/**

    DATA TYPES
        primitives:
 */

Integer num1 = 2;
String str1 = 'Hello World!';               // strings are single quotes
Boolean bool = true;
Long bigNum1 = 2147483648L;                 // whole numbers that hold more than integer can (need L)
Date currentDate = Date.today();
Date aprilFools = Date.newInstance(2024, 4, 1);     // Time, Datetime
Decimal decNum1 = 2.345;                    // floats
Double dubNum1 = 3.346346346;               // bigger decimals (like longs being bigger integers)
ID contactId = '003Hu00003b22UoIAI';        // need to wrap IDs in single quotes


Account acc = new Account();                // need to be careful with variable/object names
account acc2 = new account();               // apex is case insensitive
Account account = new Account();            // sometimes apex knows what you mean based on context

//Account ACC = new Account();              // same variable as line 41 - throws error

Course__c course = new Course__c();

account.AnnualRevenue = 500000;             // can access fields on objects in salesforce
account.Name = 'Alexander\'s Tea Emporium';
System.debug('ACCOUNT:\n' + account);       // print statement in apex
insert account;                             // directly inserts into database


OrderProcessor order = new OrderProcessor(1234);
System.debug('ORDER NUMBER: ' + order.getOrderNumber());

OrderProcessor order2 = new OrderProcessor(2345, 'IN_STORE');
System.debug(order2);
System.debug(order2.processOrder());