// Mock HTTP response
@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
    // Implement the mock HTTP callout response
    public HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setStatus('OK');
        res.setStatusCode(200);
        // res.setBody('{"animal":{"id":1,"name":"chicken","eats":"chicken food","says":"cluck cluck"}}');
        res.setBody('{"animals":["majestic badger","fluffy bunny","scary bear","chicken"]}');
        return res;
    }
}
//