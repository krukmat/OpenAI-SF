# OpenAI - Salesforce
Implementation of [OpenAI API](https://beta.openai.com/docs/api-reference/introduction) in Salesforce.
## Contents: 
1. Apex to do the callout (only completion callout so far)
2. Screen flow to invoke the apex @Invocable 
3. Custom metadata type to add the token + orgID + ...
## Setup:
1. Create an scratch org and push all the contents in this project.
2. Create the OPEN AI Setting in the Custom metadata type. It's needed only the Token field (The Org ID is not needed so far).
3. Go to The App Sales => OpenAI => Input some text as it's described in the examples of OpenAI Page 
## Intention:
It helps to integrate this revolutionary tool in our solutions in Salesforce in a very simple way.

