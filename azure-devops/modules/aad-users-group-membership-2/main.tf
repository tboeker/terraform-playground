# key = group name
# value = list of aad_users
variable "memberships" {  
  type = map( list(string) ) 
}

variable "project_id" {
  type = string
}

module "xx" {
  source      = "./../aad-users-group-membership"
  for_each    = var.memberships
  project_id  = var.project_id
  aad_users   = each.value
  group_name  = each.key
}