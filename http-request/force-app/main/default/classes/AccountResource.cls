

/**
 * REST RESOURCE
 *      signlas that this class will handle http requests.
 *          urlMapping specifies which requests to handle
 *              only need to specify the endpoint that is AFTER the base url of your org
 *                  [domainName].my.salesforce.com/services/apexrest
 * 
 *      class needs to be global.
 * 
 * 
 */
@RestResource(urlMapping='/accounts/*')     // this will handle ANY and ALL requests to /accounts
global without sharing class AccountResource {
    


    /**
     * following method has two problems:
     *      1. it is locating data itself. that is business logic. and business logic should be done in the handler. 
     *          only want traffic-cop logic. 
     *      
     *      2. it is returning data itself. this overrides ANY response we set. 
     * 
     */
    // @HttpGet
    // global static List<Account> getAccounts() {
    //     return [SELECT Id, Name FROM Account];      // Apex will automatically convert to JSON when sending http responses
    // }

    /**
     * ALL GET requests to the class URL mapping will be sent to this method. 
     *      regardless of their final endpoint.
     * 
     *      /accounts
     *      /accounts/{id}
     *      /accounts/{id}/contacts
     * 
     * 
     *      your options for handling subdomains are to have a new RestResource class per subdomain
     *      - OR - 
     *      parse them out dynamically in your methods (winner winner chicken dinner)
     * 
     * 
     */
    @HttpGet
    global static void getAccounts() {
        List<Account> accounts = new List<Account>();


        // get the rest request context
        RestRequest request = RestContext.request;

        String lastDomain = request.requestURI.substringAfterLast('/');

        switch on lastDomain {
            when 'accounts' {       // /accounts
                accounts = AccountResourceHandler.getAccounts();
            }
            when 'contacts' {       // /accounts/{id}/contacts
                String accountId = request.requestURI.substringBetween('/accounts/', '/contacts');
                accounts = AccountResourceHandler.getAccountContactsByAccountId(accountId);
            }
            when else {             // /accounts/{id}
                accounts = AccountResourceHandler.getAccountById(lastDomain);
            }
        }

        /**
         * REST RESPONSE
         *      gets the response from the overall context of the HTTP request
         *      the response will be automatically returned aonce apex method execution finishes. 
         *  
         *      manually setting responses allows for more flexibility and better error handling/reporting
         */
        RestResponse response = RestContext.response;
        if(accounts.size() > 0) {
            response.responseBody = Blob.valueOf(JSON.serialize(accounts));     // converting sObject -> JSON
            response.headers.put('Content-Type', 'application/json');           // setting file type of returned data
            response.statusCode = 200;                                          // setting "OK" status
        }
        else {
            response.responseBody = Blob.valueOf('Unable to find any accounts.');
            response.statusCode = 400;                                          // setting "BAD REQUEST" status
        }
    }

    // methods that take in arguments, can parse them out of the request body
    @HttpPost
    global static void createAccount(String name, String phone, Decimal annualRevenue) {

        // get the rest request context
        RestResponse response = RestContext.response;
        try {
            Account acc = AccountResourceHandler.createAccount(name, phone, annualRevenue);
            response.responseBody = Blob.valueOf(JSON.serialize(acc));          // converting sObject -> JSON
            response.headers.put('Content-Type', 'application/json');           // setting file type of returned data
            response.statusCode = 201;                                          // setting "CREATED" status
            
        } catch (DmlException e) {
            response.responseBody = Blob.valueOf('Unable to create account with provided data.');
            response.statusCode = 400;                                          // setting "BAD REQUEST" status
        } catch (Exception e) {
            response.responseBody = Blob.valueOf('Unable to create account. Something went wrong in the server.');
            response.statusCode = 500;                                          // setting "INTERNAL SERVER ERROR" status
        }
    }

    @HttpPut
    global static void updateAccount(String id, String name, String phone, Decimal annualRevenue) {

        // get the rest request context
        RestResponse response = RestContext.response;
        try {
            AccountResourceHandler.updateAccount(id, name, phone, annualRevenue);
            response.statusCode = 204;                                          // setting "NO CONTENT" status
            
        } catch (QueryException e) {
            response.responseBody = Blob.valueOf('Unable to locate account with provided ID.');
            response.statusCode = 404;                                          // setting "NOT FOUND" status
        } catch (DmlException e) {
            response.responseBody = Blob.valueOf('Unable to update account with provided data.');
            response.statusCode = 400;                                          // setting "BAD REQUEST" status
        } catch (Exception e) {
            response.responseBody = Blob.valueOf('Unable to update account. Something went wrong in the server.');
            response.statusCode = 500;                                          // setting "INTERNAL SERVER ERROR" status
        }
    }

    // PUT and DELETE will commonly put id in path variable rather than request body
    @HttpDelete
    global static void deleteAccount() {

        // get the rest request context
        RestResponse response = RestContext.response;
        try {
            RestRequest request = RestContext.request;
            String accountId = request.requestURI.substringAfterLast('/');
            AccountResourceHandler.deleteAccount(accountId);
            response.statusCode = 204;                                          // setting "NO CONTENT" status
            
        } catch (QueryException e) {
            response.responseBody = Blob.valueOf('Unable to locate account with provided ID.');
            response.statusCode = 404;                                          // setting "NOT FOUND" status
        } catch (DmlException e) {
            response.responseBody = Blob.valueOf('Unable to delete account with provided data.');
            response.statusCode = 400;                                          // setting "BAD REQUEST" status
        } catch (Exception e) {
            response.responseBody = Blob.valueOf('Unable to delete account. Something went wrong in the server.');
            response.statusCode = 500;                                          // setting "INTERNAL SERVER ERROR" status
        }
    }

}