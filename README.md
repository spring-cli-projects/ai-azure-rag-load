# Spring AI Retrieval Augmented Generation with Azure OpenAI

## Introduction

Retrieval Augmented Generation (RAG) is a technique that integrates your data into the AI model's responses.

* First, you need to upload the documents you wish to have analyzed in an AI respoinse into a Vector Database.
This involves breaking down the documents into smaller segments because AI models typically only manage to process a few tens of kilobytes of custom data for generating responses.
After splitting, these document segments are stored in the Vector Database.

* The second step involves including data from the Vector Database that is pertinent to your query when you make a request to the AI model.
This is achieved by performing a similarity search within the Vector Database to identify relevant content.

* In the third step, you merge the text of your request with the documents retrieved from the Vector Database before sending it to the AI model.
This process is informally referred to as 'stuffing the prompt'.

This project demonstrates the first step and uses the Azure AI Search Vector Database.

The second and third steps are done in the application in the repository https://github.com/spring-cli-projects/ai-azure-rag-chat



## Prerequisites

### Azure OpenAI Credentials

Obtain your Azure OpenAI `endpoint` and `api-key` from the Azure OpenAI Service section on [Azure Portal](https://portal.azure.com)

The Spring AI project defines a configuration property named `spring.ai.azure.openai.api-key` that you should set to the value of the `API Key` obtained from Azure

Exporting an environment variables is one way to set these configuration properties.
```shell
export SPRING_AI_AZURE_OPENAI_API_KEY=<INSERT KEY HERE>
export SPRING_AI_AZURE_OPENAI_ENDPOINT=<INSERT ENDPOINT URL HERE>
export SPRING_AI_AZURE_OPENAI_CHAT_OPTIONS_DEPLOYMENT_NAME=<INSERT NAME HERE>
```
Note, the `/resources/application.yml` references the environment variable `${SPRING_AI_AZURE_OPENAI_API_KEY}`.

## Azure AI VectorStore

TBD

## Code overview

There are two PDF files in resources directory.
They are the same except for a change in the date of when the company Carina was founded.
The first version has the year 2016 and the second version has 2017.

The class `DataLoadingJob` is responsible for processing both PDFs and attaching the version metadata field and filename to the document.
This metadata field is used later when 'chatting with your document' to select which version of the document to chat with.

## Building and running

```
./mvnw spring-boot:run
```

You can then navigate to the Azure AI Search query window and execute the query

```json
{
 "search": "What is the purpose of Carina",
 "filter": "meta_version eq 1"
}

```

## Chat with the document

Run the application in the https://github.com/spring-cli-projects/ai-azure-rag-chat repository.

