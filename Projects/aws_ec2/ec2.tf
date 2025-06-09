# key pair 
resource "aws_key_pair" "ec2_key" {
  key_name   = "terra-key-ec2"
  public_key = file("terra-key-ec2.pub")
}

# vpc
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

# scurity group
resource "aws_security_group" "ec2_security_group" {
  name        = "allow_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id # interpolaiton
  # inbound rule
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH open"

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP open"
  }


  #outbount rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"

  }

  tags = {
    Name = "allow_sg"
  }
}

# ec2 instance

resource "aws_instance" "terraform_instance" {
  for_each = tomap({
    instance1 = "t2.micro"
    instance2 = "t2.micro"
  })
  depends_on = [ aws_security_group.ec2_security_group , aws_key_pair.ec2_key ]
  ami             = var.ec2_ami_id
  instance_type   = each.value   #var.ec2_instance_type
  key_name        = aws_key_pair.ec2_key.key_name
  security_groups = [aws_security_group.ec2_security_group.name]
  user_data       = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env == "prd" ? 20: var.ec2_default_root_storage_size
    #volume_size = var.allow_root_stroage_size
    volume_type = "gp3"
  }

  tags = {
    Name = each.key # "terraform_instance"
  }
}
