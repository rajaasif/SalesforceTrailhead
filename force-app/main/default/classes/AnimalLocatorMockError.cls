@isTest
global class AnimalLocatorMockError implements HttpCalloutMock {
    // Implement the mock HTTP callout response for error
    public HTTPResponse respond(HTTPRequest req) {
        // Create a fake response for error
        HttpResponse res = new HttpResponse();
        res.setStatus('Error');
        res.setStatusCode(404);
        return res;
    }
}