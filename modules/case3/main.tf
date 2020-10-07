# case3: complex type map with functions
variable "DefaultConnection" {
  type = string
}

variable "ServiceConnections" { 
  type = map( object({
      Prefix  = string
      Postfix = string
  }))
}


output "out1" {
  value       = var.ServiceConnections
  description = "complex type"
}

# https://www.terraform.io/docs/configuration/expressions.html
output "out2" {
  value       = var.ServiceConnections[*].con1  
}

# https://www.terraform.io/docs/configuration/expressions.html#for-expressions
output "out3" {
  value       = [for s in var.ServiceConnections : upper(s.Prefix)]
}

output "out4" {
  value       = var.ServiceConnections[var.DefaultConnection]
}

output "out5" {
  value       = format("DefaultConnection: %s | Prefix: %s", 
                  var.DefaultConnection, 
                  var.ServiceConnections[var.DefaultConnection].Prefix)
}
