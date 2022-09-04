public with sharing class OpenAI {
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
        request.setHeader('Authorization','Bearer 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');
        request.setHeader('Content-Type', 'application/json');
        request.setBody(JSON.serialize(body));
        Http http = new Http();
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        
        return response.getBody();
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

