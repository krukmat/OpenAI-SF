public with sharing class OpenAI {
    private static final OpenAI_Settings__mdt setup = [SELECT Organization_ID__c, Token__c FROM OpenAI_Settings__mdt][0];
    public class Body {
        public String model;
        public String prompt;
        public Integer max_tokens;
        public Integer temperature;
    }
    private static String doCompletion(Body body) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.openai.com/v1/completions');
        request.setMethod('POST');
        request.setHeader('Authorization','Bearer '+setup.Token__c);
        request.setHeader('OpenAI-Organization', setup.Organization_ID__c);
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON.serialize(body));
        Http http = new Http();
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> choices =  (List<Object>)m.get('choices');
        Map<String, Object> c0 = (Map<String, Object>)choices[0];
        return (String)c0.get('text');
    }

    @InvocableMethod(label='Get OpenAI Text' description='Calls OpenAI and generate text based on input')
    public static List<String> generateAIText(List<String> text){
        OpenAI.Body body = new OpenAI.Body();
        body.model = 'text-davinci-002';
        body.prompt = text[0];
        body.max_tokens = 256;
        body.temperature = 0;
        return new List<String>{OpenAI.doCompletion(body)};
    }
}

