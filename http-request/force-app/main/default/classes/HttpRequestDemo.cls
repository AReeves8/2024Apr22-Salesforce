public with sharing class HttpRequestDemo {
    
    
    private static final String BASE_URL = 'https://cat-fact.herokuapp.com/facts';
    
    public HttpRequestDemo() {

    }

    // apex class to turn the JSON into
    public class CatFact {

        // class properties don't have to include every property on the JSON, but the property names do need to be exact matches
        String text;
        String type;
        Boolean deleted;
    }


    public static void simpleGetRequest() {

        // creating http request object
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');                               // setting this to a GET method
        req.setEndpoint(BASE_URL + '/random?amount=1');     // setting query param for getting back exactly 1 fact
        
        // creating HTTP object to send request
        Http http = new Http();
        HttpResponse resp = http.send(req);                 // sends Http request created above and saving the response
        System.debug(resp.getBody());

        // turning the JSON response into Apex sObject
        CatFact fact = (CatFact) JSON.deserialize(resp.getBody(), CatFact.class);   // need to cast from Object to actual class being used
        System.debug(fact);

    }


    public static void getRequestWithCredentials() {
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');                              
        req.setEndpoint('callout:Appian_EERE_Endpoint_Credentials/suite/webapi/articles'); // referencing the created Named Credentials

        // instead of setting authorization ourselves, let Saleforce manage with Named Credentials
        //req.setHeader('Authorization', 'client-id=xxxxxxx&client-secret=xxxxxxxxxxxxx');

        Http http = new Http();
        HttpResponse resp = http.send(req);

        System.debug(resp.getStatusCode());
        System.debug(resp.getBody());

    }
}