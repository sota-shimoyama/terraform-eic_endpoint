variable "name" {
  type        = string
  description = "The module name"
}

variable "az_names" {
  type        = list(string)
  description = "The AZ names"
}

variable "cidr_block" {
  type        = string
  description = "The CIDR block of VPC"
}
