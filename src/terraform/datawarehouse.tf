# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
    name     = var.resourceGroupName
    location = var.location

    tags = {
        Note = "Delete After Demo"
    }
}

resource "azurerm_storage_account" "datalake" {
  name                     = "wwiimportersdatalake001"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "datalake" {
  name               = "datalake"
  storage_account_id = azurerm_storage_account.datalake.id
}

resource "azurerm_storage_data_lake_gen2_path" "datalake" {
  path               = "datalake"
  filesystem_name    = azurerm_storage_data_lake_gen2_filesystem.datalake.name
  storage_account_id = azurerm_storage_account.datalake.id
  resource           = "directory"
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "wwi-importers-db-server"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = var.sqlAdminUser
  administrator_login_password = var.sqlAdminPassword
  minimum_tls_version          = "1.2"
}

resource "azurerm_synapse_workspace" "synapse" {
  name                                 = "wwiimporterssynapse"
  resource_group_name                  = azurerm_resource_group.rg.name
  location                             = azurerm_resource_group.rg.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.datalake.id
  sql_administrator_login              = var.sqlAdminUser
  sql_administrator_login_password     = var.sqlAdminPassword
}