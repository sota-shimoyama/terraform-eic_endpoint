locals {
  az_cnt = length(var.az_names)
}

#########
# VPC
#########
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.name}-vpc"
  }
}

# デフォルトセキュリティグループのルールを削除
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.this.id
}

##############################
# Private subnet 
##############################
resource "aws_subnet" "private" {
  count             = local.az_cnt
  vpc_id            = aws_vpc.this.id
  cidr_block        = cidrsubnet(var.cidr_block, 8, 2 + count.index)
  availability_zone = var.az_names[count.index]

  tags = {
    Name = "${var.name}-subnet-private-${var.az_names[count.index]}"
  }
}

##################################
# Private routes 
##################################
resource "aws_route_table" "private_route" {
  count  = local.az_cnt
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.name}-route-private-${count.index}"
  }
}

resource "aws_route_table_association" "private_route_association" {
  count          = local.az_cnt
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_route[count.index].id
}

##################################
# EC2 Instance Connect Endpoint
##################################
resource "aws_ec2_instance_connect_endpoint" "this" {
  subnet_id          = aws_subnet.private[0].id
  security_group_ids = [aws_security_group.eic_endpoint_sg.id]
  preserve_client_ip = false
}


#############################
# EC2 SecurityGroup
#############################
resource "aws_security_group" "ec2_sg" {
  name        = "${var.name}-ec2-sg"
  description = "${var.name}-ec2-sg"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.name}-ec2-sg"
  }
}

resource "aws_security_group_rule" "ec2_ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.eic_endpoint_sg.id
  security_group_id        = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "ec2_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}

#############################
# EIC Endpoint SecurityGroup
#############################
resource "aws_security_group" "eic_endpoint_sg" {
  name        = "${var.name}-eic_endpoint-sg"
  description = "${var.name}-eic_endpoint-sg"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name = "${var.name}-eic_endpoint-sg"
  }
}

resource "aws_security_group_rule" "eic_endpoint_egress" {
  type                     = "egress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.ec2_sg.id
  security_group_id        = aws_security_group.eic_endpoint_sg.id
}
