# case4: complex type map with foreach
terraform {
  required_providers {    
    # https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file
    local = {
      source = "hashicorp/local"
      version = "1.4.0"
    }
  }
}

variable "ServiceConnections" { 
  type = map( object({
      Prefix  = string
      Postfix = string
  }))
}

resource "local_file" "f1" {  
  for_each  = var.ServiceConnections
  filename  = format("%s/%s.txt", path.module, each.key )
  content   = each.value.Prefix
    
}

# https://www.thegreatcodeadventure.com/building-dynamic-outputs-with-terraform-for_each-for-and-zipmap/

output "out1" {
  value = keys(var.ServiceConnections)
}

output "out2" {
  value = values(local_file.f1)[*]["filename"]
}

output "out3" {
  value = zipmap(
      sort(keys(var.ServiceConnections)), 
      sort(values(local_file.f1)[*]["filename"])
      )
}

output "out4" {
  value = [
    for con, file in zipmap(
        sort(keys(var.ServiceConnections)), 
        sort(values(local_file.f1)[*]["filename"])) :
        map("con-name", con, "file-name", file)
    ] 
}