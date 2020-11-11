terraform {
  required_version = ">= 0.13"
  required_providers {        
    azuredevops = {
      source  = "terraform-providers/azuredevops"
      version = ">= 0.0.1"
    }
  }  
}
