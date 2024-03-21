public class AnimalLocator {
    public static List<String> getAnimalNameById() {
        String endpoint = 'https://th-apex-http-callout.herokuapp.com/animals/';
        
        // Make the HTTP request
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        
        // Invoke the callout
        Http http = new Http();
        HttpResponse res = http.send(req);
        
        // Check the response
        if (res.getStatusCode() == 200) {
            // Parse the JSON response
            // Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            // Map<String, Object> animalData = (Map<String, Object>)jsonResponse.get('animal');
            System.debug(res.getBody());
            AnimalResponse abb= AnimalResponse.parse(res.getBody());
           List<String> name= abb.animals;
            return name;
        } else {
            // Handle error response
            return null;
        }
    }
}