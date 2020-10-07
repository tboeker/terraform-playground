variable "ServiceConnections" { 
  type = map( object({
      Prefix  = string
      Postfix = string
  }))
}

output "out1" {
  value       = "output1"
  description = "static value"
}

output "out2" {
  value       = var.ServiceConnections
  description = "complex type"
}

# output "out3" {
#   value       = local.merged_my_settings.string1
#   description = "static value of complex type"
# }

