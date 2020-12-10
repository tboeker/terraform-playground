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



output "aks_name" {
  value = module.naming.kubernetes_cluster.name
}

output "aks_name_unique" {
  value = module.naming.kubernetes_cluster.name_unique
}


output "acr_name" {
  value = module.naming.container_registry.name
}

output "acr_name_unique" {
  value = module.naming.container_registry.name_unique
}