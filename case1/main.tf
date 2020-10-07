# Object type Variable

variable "my_settings" {
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



output "out1" {
  value       = "output1"
  description = "static value"
}

output "out2" {
  value       = var.my_settings
  description = "complex type"
}

output "out3" {
  value       = var.my_settings.string1
  description = "static value of complex type"
}
