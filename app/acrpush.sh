#!/bin/bash

acrName="acrimds"
localImageTag="azureimds"
acrImageUrl="$acrName.azurecr.io/app:latest"

az acr login --name $acrName
docker build -t $localImageTag .
docker tag $localImageTag $acrImageUrl
docker push $acrImageUrl