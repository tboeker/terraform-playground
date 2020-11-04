variable "aad_users" {
  type        = list(string)
}

variable "project_id" {
  type = string
}

variable "group_name" {
  type = string
}

data "azuredevops_users" "aad" {
  for_each  = toset(var.aad_users)
  principal_name = each.value
}

output "users_descriptors" {
  value = flatten(values(data.azuredevops_users.aad)[*].users[*].descriptor)
}

data "azuredevops_group" "group" {
  project_id = var.project_id
  name       = var.group_name
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