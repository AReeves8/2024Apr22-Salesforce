@IsTest
public with sharing class HttpRequestDemo_Test {
    
    @IsTest
    public static void testSimpleGetRequestPositiveResponse() {

        // create mock
        HttpMockFactory httpMock = new HttpMockFactory();
        httpMock.setBody('{"status":{"verified":null,"sentCount":0},"_id":"6409697a92271493a95633df","user":"640027109444b2a501a06ba8","text":"Cat it the best animal in the world5.","type":"cat","deleted":false,"createdAt":"2023-03-09T05:07:06.171Z","updatedAt":"2023-03-09T05:07:06.171Z","__v":0}');
        httpMock.setCode(200);
        httpMock.setStatus('OK');


        // set the test to use the mock
        // replace the actual callout to the external system with the respond method from the mock class
        Test.setMock(HttpCalloutMock.class, httpMock);

        Test.startTest();
            Boolean result = HttpRequestDemo.simpleGetRequest();
        Test.stopTest();


        Assert.areEqual(true, result, '200 code gives positive results');
    }


    @IsTest
    public static void testSimpleGetRequestNegativeResponse() {

        // create mock
        HttpMockFactory httpMock = new HttpMockFactory();
        httpMock.setBody('{"status":{"verified":null,"sentCount":0},"_id":"6409697a92271493a95633df","user":"640027109444b2a501a06ba8","text":"Cat it the best animal in the world5.","type":"cat","deleted":false,"createdAt":"2023-03-09T05:07:06.171Z","updatedAt":"2023-03-09T05:07:06.171Z","__v":0}');
        httpMock.setCode(400);
        httpMock.setStatus('BAD REQUEST');


        // set the test to use the mock
        // replace the actual callout to the external system with the respond method from the mock class
        Test.setMock(HttpCalloutMock.class, httpMock);

        Test.startTest();
            Boolean result = HttpRequestDemo.simpleGetRequest();
        Test.stopTest();


        Assert.areEqual(false, result, '400 code gives negative results');
    }

}