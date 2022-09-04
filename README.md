# OpenAI - Salesforce
Implementation of [OpenAI API](https://beta.openai.com/docs/api-reference/introduction) in Salesforce.
## Contents: 
### Ask me anything utility
1. Apex to do the callout: OpenAI class
2. Screen flow to invoke the apex @Invocable 
![imagename](https://github.com/krukmat/OpenAI-SF/blob/a13cf1e828f892416ad613e8786027176376b20c/images/2.png)
![imagename](https://github.com/krukmat/OpenAI-SF/blob/a13cf1e828f892416ad613e8786027176376b20c/images/3.png)
3. Custom metadata type to add the token + orgID + ...
![imagename](https://github.com/krukmat/OpenAI-SF/blob/a13cf1e828f892416ad613e8786027176376b20c/images/6.png)
### Chatter moderation framework
Based on the moderation algorithm implemented in [OpenAI Api][https://beta.openai.com/docs/guides/moderation/overview]
1. Apex to do the callout: OpenAI class
2. Apex Triggers for FeedItem and FeedComments for Chatter
3. Custom metadata type to add the moderator parameters as violation message, moderation scoring, ...
![imagename](https://github.com/krukmat/OpenAI-SF/blob/a13cf1e828f892416ad613e8786027176376b20c/images/6.png)

## Setup:
1. Create an scratch org and push all the contents in this project.
2. Create the OPEN AI Setting in the Custom metadata type. It's needed the Token field, Moderation Score (0..1) and Violation Message to show when a post in chatter has a score superior than the moderation score.
3. Go to The App Sales => OpenAI => Input some text as it's described in the examples of OpenAI Page 
4. Go to Chatter => Post a status and check the moderation. I suggest you to put a value < 0.02 to see quicker the results.
## Intention:
It helps to integrate this revolutionary tool in our solutions in Salesforce in a very simple way. Also I propose a solution for moderation in Chatter using the Moderation algorithm in GPT-3

