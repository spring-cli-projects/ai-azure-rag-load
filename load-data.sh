#!/bin/sh


if [ -z "$RESOURCE_GROUP" ] || [ -z "$SPRING_APPS_SERVICE" ]; then
    echo "Error: RESOURCE_GROUP and SPRING_APPS_SERVICE environment variables must be set."
    exit 1
fi

az spring job create -g ${RESOURCE_GROUP} -s ${SPRING_APPS_SERVICE} --name ai-azure-rag-load

az spring job deploy -g ${RESOURCE_GROUP} -s ${SPRING_APPS_SERVICE} --name ai-azure-rag-load --artifact-path ./target/spring-ai-rag-load-0.0.1-SNAPSHOT.jar --build-env BP_JVM_VERSION=17


az spring job start -g ${RESOURCE_GROUP} -s ${SPRING_APPS_SERVICE}  --name ai-azure-rag-load

az spring job execution list -g ${RESOURCE_GROUP} -s ${SPRING_APPS_SERVICE} --job ai-azure-rag-load --query '[].{startTime:startTime, endTime:endTime, name:name, status:status}' --output table

