module "naming" { 
  source  = "Azure/naming/azurerm"
  version = ">= 0.1.0"
  suffix = [ "test" ]
}

output "rg_name" {
  value = module.naming.resource_group.name
}

output "rg_name_unique" {
  value = module.naming.resource_group.name_unique
}