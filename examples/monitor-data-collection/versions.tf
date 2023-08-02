terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.66.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.8.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }
  }
}
provider "azurerm" {
  features {}
}
provider "azapi" {
}