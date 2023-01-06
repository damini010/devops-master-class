terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.38.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  subscription_id = "67f3cd8f-805a-48e8-97b4-2fb0bca9b7be"
  tenant_id  ="07fd1472-3b9c-42bd-a589-ce8b58e44eee"
  client_id = "d70f747c-a684-46d0-98fe-d17f36bd27b3"
  client_secret = "~KM8Q~gLweRrMWs7iGq8z2zC2TWlgj7aC-2iicc-"
  features {}
}

resource "azurerm_resource_group" "my_azurerg" {
  name     = "terraform-iac-rg"
  location = "North Central US"
}

resource "azurerm_storage_account" "terraformstorageaccforaz" {
  name                     = "terraformstorageaccforaz"
  resource_group_name      = azurerm_resource_group.my_azurerg.name
  location                 = azurerm_resource_group.my_azurerg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind = "StorageV2"
}

resource "azurerm_storage_container" "terrformsacontainer" {
  name                  = "terrformsacontainer"
  storage_account_name  = "terraformstorageaccforaz"
  container_access_type = "blob"
}

resource "azurerm_storage_blob" "maintf" {
  name                   = "main.tf"
  storage_account_name   = azurerm_storage_account.terraformstorageaccforaz.name
  storage_container_name = azurerm_storage_container.terrformsacontainer.name
  type                   = "Block"
  source                 = "main.tf"
}