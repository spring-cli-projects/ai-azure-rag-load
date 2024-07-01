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

### Azure OpenAI setup

1. Obtain your Azure OpenAI `endpoint` and `api-key` from the Azure OpenAI Service section on [Azure Portal](https://portal.azure.com) and deploy a chat model, such as `gpt-35-turbo-16k` and an embedding model such as `text-embedding-ada-002`.

2. Create an instance of [Azure AI Search vector database](https://azure.microsoft.com/en-us/products/ai-services/ai-search/) and obtain the API keys and URL.

Here is the `application.yml` file for the application. You will need to fill in the appropriate API keys, model names, and endpoints.
Only the API keys have been removed in the configuration.

```yaml
spring:
  ai:
    azure:
      openai:
        api-key: 
        endpoint: https://springai.openai.azure.com/
        chat:
          options:
            deployment-name: gpt-35-turbo-16k
        embedding:
          options:
            deployment-name: text-embedding-ada-002
    vectorstore:
      azure:
        api-key: 
        url: https://springaisearch.search.windows.net
        index-name: carina_index
```



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

