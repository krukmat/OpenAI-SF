# OpenAI - Salesforce
Implementation of [OpenAI API](https://beta.openai.com/docs/api-reference/introduction) in Salesforce.
## Contents: 
1. Apex to do the callout (only completion callout so far)
2. Screen flow to invoke the apex @Invocable 
![imagename](https://github.com/krukmat/OpenAI-SF/blob/a13cf1e828f892416ad613e8786027176376b20c/images/2.png)
![imagename](https://github.com/krukmat/OpenAI-SF/blob/a13cf1e828f892416ad613e8786027176376b20c/images/3.png)
3. Custom metadata type to add the token + orgID + ...
![imagename](https://github.com/krukmat/OpenAI-SF/blob/a13cf1e828f892416ad613e8786027176376b20c/images/6.png)
## Setup:
1. Create an scratch org and push all the contents in this project.
2. Create the OPEN AI Setting in the Custom metadata type. It's needed only the Token field (The Org ID is not needed so far).
3. Go to The App Sales => OpenAI => Input some text as it's described in the examples of OpenAI Page 
## Intention:
It helps to integrate this revolutionary tool in our solutions in Salesforce in a very simple way.

