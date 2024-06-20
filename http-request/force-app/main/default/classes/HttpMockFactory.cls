@IsTest
public class HttpMockFactory implements HttpCalloutMock {
    
    private Integer code;
    private String status;
    private String body;        // JSON String
    private Map<String, String> responseHeaders;
    
    public HttpMockFactory() {

    }

    public HttpMockFactory(Integer code, String status, String body, Map<String, String> responseHeaders) {
        this.code = code;
        this.status = status;
        this.body = body;
        this.responseHeaders = responseHeaders;
    } 


    public Integer getCode() {
        return this.code;
    }
    public void setCode(Integer code) {
        this.code = code;
    }

    public String getStatus() {
        return this.status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getBody() {
        return this.body;
    }
    public void setBody(String body) {
        this.body = body;
    }

    public Map<String, String> getResponseHeaders() {
        return this.responseHeaders;
    }
    public void setResponseHeaders(Map<String, String> responseHeaders) {
        this.responseHeaders = responseHeaders;
    }

    // implementing the method from HttpCalloutMock
    public HttpResponse respond(HttpRequest req) {
        HttpResponse response = new HttpResponse();

        if(this.code != null) {
            response.setStatusCode(this.code);
        }
        if(this.status != null) {
            response.setStatus(this.status);
        }
        if(this.body != null) {
            response.setBody(this.body);
        }
        if(this.responseHeaders != null) {
            for(String key : this.responseHeaders.keySet()) {
                response.setHeader(key, this.responseHeaders.get(key));
            }
        }
        return response;
    }
}