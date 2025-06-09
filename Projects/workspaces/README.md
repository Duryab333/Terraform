## Terraform Workspaces

Terraform workspaces allow you to manage multiple environments (e.g., development, staging, production) within the same configuration. Each workspace maintains a separate state file, enabling isolated deployments without duplicating code.

**Key Benefits:**
- Environment Isolation – Keep different environments (e.g., dev/prod) separate.
- State Management – Each workspace has its own Terraform state.
- Efficient Workflow – Easily switch between workspaces without modifying configurations.

**Basic Commands:**
```
terraform workspace new --name    # Create a new workspace  
terraform workspace list       # List all workspaces  
terraform workspace select dev # Switch to a workspace  
terraform workspace show
```
### Project
This project includes creating 3 differnet enviornments for development, staging and production. 
The tree of project is:

![image](https://github.com/user-attachments/assets/17fa3edf-2f28-4292-875e-136cc2691b67)


```
terraform workspace new dev
terraform workspace new stage
terraform workspace new prod 

```
the main.tf file use the module of creating ec2 instance.
```
provider "aws" {
    region = "us-east-1"
  
}
variable "ami" {
    description = "value"
    
}
variable "instance_type" {
    description = "value"  
      type = map(string)  
    default = {
      "dev" = "t2.micro"
      "stage" = "t2.micro"
      "prod" = "t2.micro"
    }  
}

module "ec2_instance" {
    source = "./modules/ec2_instances"
    ami = var.ami
    instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}



```



**How It Works**
- The terraform.workspace value determines which instance_type to use.
- The lookup() function fetches the correct instance type from the instance_type map.
- The EC2 module (modules/ec2) is used to manage the instance.

**How to Run**
Go to specific workspace and run `terraform init` , `terraform plan` then, `terraform apply` command. It will create the requiered resources for the enviornment used. 
or 
Different .tfvars files can be use for dev, stage and prod enviornments when do terraform apply by:
```
terraform apply -var-file = stage.tfvars

```
