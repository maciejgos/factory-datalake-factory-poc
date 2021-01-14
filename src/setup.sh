#!/bin/bash
RESOURCE_GROUP_NAME=rg-datawarehouse-poc
LOCATION=westeurope
DB_STORAGE_ACCOUNT=wwiimportersdbdata001

echo "Create Resource Group"
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account for DB backup
az storage account create --name $DB_STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP_NAME --sku Standard_LRS

# Upload backup [TODO]

# Deploy ARM template
az deployment group create --name Initial --resource-group $RESOURCE_GROUP_NAME --template-file ./src/template.json 

# Create Data Factory [TODO]

# Create Synapse [TODO]