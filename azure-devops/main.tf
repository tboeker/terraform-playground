# Make sure to set the following environment variables:
#   AZDO_PERSONAL_ACCESS_TOKEN
#   AZDO_ORG_SERVICE_URL
data "azuredevops_client_config" "c" {}

output "org_url" {
  value = data.azuredevops_client_config.c.organization_url
}

variable "aad_users" {
  description = "A list of AAD user emails that will be granted access to the provisioned project. These are assumed to be part of an AAD group linked to the AzDO org. eg  [\"shanw_cicoria@microsoft.com\"]"
  type        = list(string)
  default     = [
      "tb@softwarepioniere.de",
      "mvd@softwarepioniere.de"
  ]
}

data "azuredevops_project" "p" {
  project_name = "Test1"
}

output "p_id" {
  value = data.azuredevops_project.p.id
}

data "azuredevops_users" "aad" {
  for_each  = toset(var.aad_users)
  principal_name = each.value
}

# output "users_raw" {
#   value = data.azuredevops_users.aad
# }

output "users_descriptors" {
  value = flatten(values(data.azuredevops_users.aad)[*].users[*].descriptor)
}

data "azuredevops_group" "group" {
  project_id = data.azuredevops_project.p.id
  name       = "Build Administrators"
}

output "group_id" {
  value = data.azuredevops_group.group.id
}

output "group_descriptor" {
  value = data.azuredevops_group.group.descriptor
}

resource "azuredevops_group_membership" "membership" {
  group = data.azuredevops_group.group.descriptor
  members = flatten(values(data.azuredevops_users.aad)[*].users[*].descriptor)
}