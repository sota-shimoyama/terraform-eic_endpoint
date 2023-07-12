variable "name" {
  type        = string
  description = "The module name"
}

variable "az_names" {
  type        = list(string)
  description = "The AZ names"
}

variable "subnet_private_ids" {
  type        = list(string)
  description = "The private subnet ids"
}

variable "ec2_security_groups" {
  type        = string
  description = "The ID of EC2 Security Group"
}

variable "instance_type" {
  type        = string
  description = "The instance type of EC2"
}

variable "vpc_id" {
  type        = string
  description = "vpc_id"
}

variable "volume_type" {
  type        = string
  description = "The EC2 volume type."
}

variable "volume_size" {
  type        = number
  description = "The EC2 volume size."
}
