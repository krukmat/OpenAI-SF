public with sharing class OpenAI {
    private static Decimal maxCat = -1;
    private static final OpenAI_Settings__mdt setup = [SELECT Moderation_Score__c, Organization_ID__c, Token__c FROM OpenAI_Settings__mdt][0];
    public abstract class Body {
    }
    public class BodyCompletion extends Body{
        public String model;
        public String prompt;
        public Integer max_tokens;
        public Integer temperature;
    }

    public class BodyModeration extends Body{
        public String input;
    }

    private static HttpRequest doCallout(String method, String api){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.openai.com/v1/'+api);
        request.setMethod(method);
        request.setHeader('Authorization','Bearer '+setup.Token__c);
        request.setHeader('OpenAI-Organization', setup.Organization_ID__c);
        request.setHeader('Content-Type', 'application/json');
        return request;
    }  

    private static String doCompletion(Body body) {
        HttpRequest request = OpenAI.doCallout('POST','completions');
        request.setBody(JSON.serialize(body));
        Http http = new Http();
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> choices =  (List<Object>)m.get('choices');
        Map<String, Object> c0 = (Map<String, Object>)choices[0];
        return (String)c0.get('text');
    }

    public static String doModeration(Body body) {
        maxCat = -1;
        HttpRequest request = OpenAI.doCallout('POST','moderations');
        request.setBody(JSON.serialize(body));
        Http http = new Http();
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        return response.getBody();
    }

    @InvocableMethod(label='Get OpenAI Text' description='Calls OpenAI and generate text based on input')
    public static List<String> generateAIText(List<String> text){
        OpenAI.BodyCompletion body = new OpenAI.BodyCompletion();
        body.model = 'text-davinci-002';
        body.prompt = text[0];
        body.max_tokens = 256;
        body.temperature = 0;
        return new List<String>{OpenAI.doCompletion(body)};
    }

    private static void addCategory2Map(Map<String, Decimal> scores, JSONParser parser){
        parser.nextToken(); 
        String category = parser.getText();
        parser.nextToken(); // value
        Decimal value = parser.getDecimalValue();
        if (maxCat < value){
            maxCat = value;
        }
        scores.put(category, value);
    }


    private static Boolean doModerationEvaluation(Body body){
        String output = OpenAI.doModeration(body);
        JSONParser parser = JSON.createParser(output);
        Map<String, Decimal> scores = new Map<String, Decimal>();
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
            (parser.getText() == 'category_scores')) {
                parser.nextToken();
                addCategory2Map(scores, parser); // hate
                addCategory2Map(scores, parser); // hate-threatening
                addCategory2Map(scores, parser); // self-harm
                addCategory2Map(scores, parser); // sexual
                addCategory2Map(scores, parser); // sexual-minors
                addCategory2Map(scores, parser); // violence
                addCategory2Map(scores, parser); // violence-graphic
            }
            /*if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
            (parser.getText() == 'flagged')) {
                parser.nextToken();
                flagged = parser.getBooleanValue();
            }*/
        }
        return maxCat > setup.Moderation_Score__c;
    }
    /**
     * Boolean: Shouldn't be moderated?
     */
    @future(callout=true)
    public static void moderationCategory(Id feedID){
        FeedItem feed = [SELECT body, status FROM FeedITem WHERE ID = :feedID];
        Boolean flagged = false;
        OpenAI.BodyModeration body = new OpenAI.BodyModeration();
        body.input = feed.body;
        if (doModerationEvaluation(body)){
            feed.body = 'Erased content due to violation of community rules';
            update feed;
        }
    }

    @future(callout=true)
    public static void moderationCommentCategory(Id feedID){
        FeedComment feed = [SELECT commentBody, status FROM FeedComment WHERE ID = :feedID];
        Boolean flagged = false;
        OpenAI.BodyModeration body = new OpenAI.BodyModeration();
        body.input = feed.commentBody;
        if (doModerationEvaluation(body)){
            feed.commentBody = 'Erased content due to violation of community rules';
            update feed;
        }
    }
}

