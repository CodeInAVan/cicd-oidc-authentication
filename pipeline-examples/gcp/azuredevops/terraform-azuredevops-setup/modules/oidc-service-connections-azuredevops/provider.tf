terraform {

  required_version = ">=0.12"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.0"
    }
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">=0.1.0"
    }
  }
}
