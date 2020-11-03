# case5: complex type with map as attribute and foreach
terraform {
  required_providers {    
    # https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
    local = {
      source = "hashicorp/local"
      version = "1.4.0"
    }
  }
}

variable "my_settings_defaults" {  
  type = object({
    string1           = string
    number1           = number
    bool1             = bool,
    DefaultConnection = string,
    ServiceConnections = map( object({
      Prefix  = string
      Postfix = string
      }))
  })

  default = {
    string1 = "string 1 default"
    number1 = 123
    bool1   = true
    DefaultConnection = null
    ServiceConnections = {}  
  }
}

variable "my_settings" {
  description = "Map of settings to be applied which will be merged with the settings_defaults. Allowed keys are the same as for mysettings_defaults."
}

locals {
  merged_my_settings = merge(var.my_settings_defaults, var.my_settings)
}

resource "local_file" "f1" {  
  for_each  = local.merged_my_settings.ServiceConnections
  filename  = format("%s/%s.txt", path.module, each.key )
  content   = each.value.Prefix
    
}

output "out1" {
  value = keys(local.merged_my_settings.ServiceConnections)
}

output "out2" {
  value = values(local_file.f1)[*]["filename"]
}

output "out3" {
  value = zipmap(
      sort(keys(local.merged_my_settings.ServiceConnections)), 
      sort(values(local_file.f1)[*]["filename"])
      )
}

output "out4" {
  value = [
    for con, file in zipmap(
        sort(keys(local.merged_my_settings.ServiceConnections)), 
        sort(values(local_file.f1)[*]["filename"])) :
        map("con-name", con, "file-name", file)
    ] 
}

output "out5" {
  value       = local.merged_my_settings.ServiceConnections[local.merged_my_settings.DefaultConnection]
}