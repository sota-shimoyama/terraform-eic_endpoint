output "instance_id" {
  value       = aws_instance.this[0].id
  description = "The ID of EC2 Instance"
}
