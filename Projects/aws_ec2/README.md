# EC2 instance creation with automated Nginx installation:

This will create all the configuraiton required to make an ec2 instance on AWS

-  key-pair
-  VPC
-  security gorups
-  ec2-instance

## 1) AWS configure

## 2) Key-Pair file generaiton

```
ssh-keygen -f terra-key-ec2
```
## Vaiables

In `Variable.tf` change the ami-id and other variables according to your requirment.

## Finally

Run the basic command to run the terraform file.

```
terraform init
terraform validate
terraform plan
terraform apply -auto-approve
```

## Meta-Arguments

### Multiple instances

#### Use of Count
In aws_instance block use attribute `count` suppose count=2 to make multiple instances.
For the output variable make chanes in line :

```
values = aws_instance.instance_name[*].value

```
#### Use of for_each

```
for-each = tomap{
key1 = "value1"
key2 = "value2"
}
```

to use them just use `each.key` where you have to put key and `each.value` where you have to use value.

#### Use of depends-on

until specific resources are not make do not make that resource that has meta-argumnet of depends_on

```
depends_on = [ aws_security_group.ec2_security_group , aws_key_pair.ec2_key ]
```

## Conditional Expression

variable = condition ? True : False

example: if the enviornment is produciton then volum size of ec2 is 20GB if not (in developemnt) then 8GB 

```
volume_size = var.env == "prd" ? 20: 8

```
