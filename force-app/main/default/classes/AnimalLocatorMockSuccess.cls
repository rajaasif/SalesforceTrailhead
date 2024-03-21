@isTest
global class AnimalLocatorMockSuccess implements HttpCalloutMock {
    // Implement the mock HTTP callout response for success
    public HTTPResponse respond(HTTPRequest req) {
        // Create a fake response for success
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setStatusCode(200);
        res.setBody('{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}');
        return res;
    }
}