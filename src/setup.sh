#!/bin/bash
RESOURCE_GROUP_NAME=rg-datawarehouse-poc
LOCATION=westeurope
DB_STORAGE_ACCOUNT=wwiimportersdbdata001
SQL_USER=sqluser
SQL_USER_PASSWORD=P@ssw0rd!

echo "Create Resource Group"
az group create --name $RESOURCE_GROUP_NAME --location $LOCATION

# Create storage account for DB backup
az storage account create --name $DB_STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP_NAME --sku Standard_LRS

# Upload backup [TODO]

# Deploy ARM template
echo "Deploy ARM template"
az deployment group create --name Initial --resource-group $RESOURCE_GROUP_NAME --template-file template.json --parameters template.parameters.json

# Create Data Factory [TODO]

# Create Synapse
echo "Create Azure Synapse"
az synapse workspace create --name wwi-importers-synapse --resource-group $RESOURCE_GROUP_NAME --storage-account wwiimportersdatalake001 --file-system data --sql-admin-login-user $SQL_USER --sql-admin-login-password $SQL_USER_PASSWORD --location $LOCATION