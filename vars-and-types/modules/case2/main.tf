# case2: complex type as variable with default and optional attributes
# https://binx.io/blog/2020/01/02/module-parameter-defaults-with-the-terraform-object-type/

variable "my_settings_defaults" {
  type = object({
    string1 = string
    number1 = number
    bool1   = bool
  })

  default = {
    string1 = "string 1 default"
    number1 = 123
    bool1   = true
  }
}

variable "my_settings" {
  description = "Map of settings to be applied which will be merged with the settings_defaults. Allowed keys are the same as for mysettings_defaults."
}

locals {
  merged_my_settings = merge(var.my_settings_defaults, var.my_settings)
}

output "out1" {
  value       = local.merged_my_settings
  description = "complex type"
}

output "out2" {
  value       = local.merged_my_settings.string1
  description = "static value of complex type"
}
