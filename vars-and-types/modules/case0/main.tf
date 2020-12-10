variable "var1" {
  type = string
}


output "out1" {
  value       = format("out-%s", var.var1)
  description = "input var 1"
}