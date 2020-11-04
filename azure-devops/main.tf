# Make sure to set the following environment variables:
#   AZDO_PERSONAL_ACCESS_TOKEN
#   AZDO_ORG_SERVICE_URL
data "azuredevops_client_config" "c" {}

output "org_url" {
  value = data.azuredevops_client_config.c.organization_url
}

data "azuredevops_project" "p" {
  project_name = "Test1"
}

output "p_id" {
  value = data.azuredevops_project.p.id
}

module "aad_user_membership" {
  source      = "./modules/aad-users-group-membership"
  project_id  = data.azuredevops_project.p.id
  aad_users   = = [
      "tb@softwarepioniere.de",
      "mvd@softwarepioniere.de",
      "mkb@softwarepioniere.de"
  ]
  group_name  = "Build Administrators"
}