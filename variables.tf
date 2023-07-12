variable "env" {
  type        = string
  description = "Current state of project: develop, prod, stage..."
}

variable "project" {
  type        = string
  description = "The Project prefix."
}

variable "profile" {
  type        = string
  description = "The profile name."
}

variable "az_cnt" {
  type        = number
  description = "Number of AZs to cover"
  default     = 2
}

variable "vpc_cidr_block" {
  type        = string
  description = "IPv4"
}

variable "instance_type" {
  type        = string
  description = "The EC2 instance type."
}

variable "volume_type" {
  type        = string
  description = "The EC2 volume type."
}

variable "volume_size" {
  type        = number
  description = "The EC2 volume size."
}
