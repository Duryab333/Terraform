output "ec2_public_ip" {
  description = "Public IP of Ec2 instances"
  value       = [ for instance in aws_instance.terraform_instance :  instance.public_ip ]
  # value = aws_instance.terraform_instance.public_ip  ---- for just 1 instance 
}

output "ec2_public_dns" {
  description = "Public DNS value of Ec2 instances"
#  value      = aws_instance.terraform_instance.public_dns
   value      = [ for instance in aws_instance.terraform_instance : instance.public_dns ]

}
output "ec2_private_ip" {
    description = "Private IP address values of Ec2 Instances"
    #value = aws_instance.terraform_instance.private_ip
    value =  [ for instance in aws_instance.terraform_instance : instance.private_ip ]
}
