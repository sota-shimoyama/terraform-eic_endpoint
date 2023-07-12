output "vpc_id" {
  value       = aws_vpc.this.id
  description = "The ID of VPC"
}

output "subnet_private_ids" {
  value       = aws_subnet.private[*].id
  description = "The IDs of private subnets"
}

output "eic_endpoint_security_group_id" {
  value       = aws_security_group.eic_endpoint_sg.id
  description = "The ID of EIC Endpoint Security Group"
}

output "eic_endpoint_id" {
  value       = aws_ec2_instance_connect_endpoint.this.id
  description = "The ID of EIC Endpoint"
}

output "ec2_security_group_id" {
  value       = aws_security_group.ec2_sg.id
  description = "The ID of EC2 Security Group"
}
