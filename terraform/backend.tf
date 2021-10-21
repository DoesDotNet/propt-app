terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.81.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "propt-tf-test-rg-ukso"
    storage_account_name = "propttftestsaukso"
    container_name       = "terraformstate"
    key                  = "propt-app.tfstate"
  }
}

provider "azurerm" {
  features {}
}