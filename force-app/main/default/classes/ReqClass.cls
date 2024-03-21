public class ReqClass {
    public static void getData() {
        HttpRequest req=new HttpRequest();
        req.setEndpoint('https://reqres.in/api/register');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        req.setBody('{"email": "eve.holt@reqres.in","password": "pistol"}');
        Http http= new Http();
        HttpResponse res=http.send(req);
            System.debug(res.getBody());
            // ReqRes reqres=ReqRes.parse(res.getBody());
            // List<ReqRes.Data> data=reqres.data;
            // for (ReqRes.Data req_data : data) {
            //     if(req_data.id=1)
            //     System.debug(req_data.first_name);
                
            // }
        //     return data;
        // }
        // else 
        //     return null;

    
}
}