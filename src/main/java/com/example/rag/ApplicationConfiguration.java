package com.example.rag;

import com.azure.search.documents.indexes.SearchIndexClient;
import org.springframework.ai.embedding.EmbeddingClient;
import org.springframework.ai.vectorstore.azure.AzureVectorStore;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.List;

@Configuration
public class ApplicationConfiguration {

	@Bean
	public AzureVectorStore vectorStore(SearchIndexClient searchIndexClient, EmbeddingClient embeddingClient) {
		var vectorStore = new AzureVectorStore(searchIndexClient, embeddingClient,
				List.of(AzureVectorStore.MetadataField.text("filename"),
						AzureVectorStore.MetadataField.int32("version")));
		vectorStore.setIndexName("carina-index");
		return vectorStore;
	}


}
