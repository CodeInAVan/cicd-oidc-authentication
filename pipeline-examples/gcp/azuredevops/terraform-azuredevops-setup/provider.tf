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

provider "azurerm" {
  features {}
}

provider "azuredevops" {
  org_service_url       = "< azure dev ops organisation service url e.g. https://dev.azure.com/<org name> >"
  personal_access_token = "< azuredevops personal access token >"
}