output "instance_public_ip_address" {
    description = "public ip address of instance"
    value = aws_instance.example.public_ip
  
}