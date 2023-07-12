locals {
  az_cnt = length(var.az_names)
}

data "aws_ssm_parameter" "amzn2023_latest" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-6.1-arm64"
}

##############################
# EC2 Instance
##############################
resource "aws_instance" "this" {
  count                       = local.az_cnt
  ami                         = data.aws_ssm_parameter.amzn2023_latest.value
  instance_type               = var.instance_type
  associate_public_ip_address = false
  subnet_id                   = var.subnet_private_ids[count.index]
  security_groups             = [var.ec2_security_groups]

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
    tags = {
      Name = "${var.name}-ebs-${count.index}"
    }
  }

  tags = {
    Name = "${var.name}-instance-${count.index}"
  }
}
