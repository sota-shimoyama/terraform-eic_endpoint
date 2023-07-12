###########
# Provider
###########
terraform {
  required_version = ">= 1.2.6"
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = var.profile
}

##################
# Local Variables
##################
locals {
  az_names = slice(data.aws_availability_zones.available.names, 0, var.az_cnt)
  name     = "${var.project}-${var.env}"
}

##################
# Outputs
##################
output "Connect_from_the_management_console_or_use_the_following_command" {
  value = "aws ec2-instance-connect ssh --instance-id ${module.ec2.instance_id} --eice-options maxTunnelDuration=3600,endpointId=${module.vpc.eic_endpoint_id} --os-user ec2-user"
}



#################
# Avaiable Zones
#################
data "aws_availability_zones" "available" {
  state = "available"
}

#########
# VPC
#########
module "vpc" {
  source = "./modules/vpc"

  name       = local.name
  cidr_block = var.vpc_cidr_block
  az_names   = local.az_names
}

##############
# EC2
##############
module "ec2" {
  source = "./modules/ec2"

  name                = local.name
  subnet_private_ids  = module.vpc.subnet_private_ids
  instance_type       = var.instance_type
  az_names            = local.az_names
  vpc_id              = module.vpc.vpc_id
  volume_type         = var.volume_type
  volume_size         = var.volume_size
  ec2_security_groups = module.vpc.ec2_security_group_id
}
