# Terraform Project: Creating an EC2 Instance on AWS  

This project demonstrates how to use Terraform to provision an EC2 instance on AWS. It covers essential Terraform concepts such as providers, resources, variables, modularizatoin and outputs.  

## Project Structure  
The Terraform project consists of two files main.tf and three files in modules/ec2_instances:  

1. **main.tf** – Defines the AWS provider and the EC2 instance resource. This file specifies the instance configuration, including the AMI, instance type, and other necessary parameters.  
2. **variables.tf** – Declares input variables such as the AMI ID and EC2 instance type, making the configuration more flexible and reusable.  
3. **outputs.tf** – Specifies output variables to display important information, such as the public IP address of the created EC2 instance.
extra file:
5. **terraform.tfvars** – Assigns values to the input variables defined in variables.tf. This file allows easy configuration changes without modifying the main Terraform code.

terraform.tfvars file is not needed if you are doing modularization and passing the variables inside the main.tf file while calling the module.

## Variables  
Terraform uses variables to manage configuration settings efficiently.  

### Input Variables  
Input variables are declared in `variables.tf` and can be assigned values through the `terraform.tfvars` file. This approach helps maintain clean, reusable configurations while enabling different setups for various environments (development, staging, production).  

### Output Variables  
Output variables, defined in `outputs.tf`, capture and display key details about the infrastructure after Terraform applies the configuration. In this project, the public IP address of the EC2 instance is retrieved and printed as an output.  

## Running the Project  
To deploy the EC2 instance using Terraform:  

1. **Initialize Terraform**  
   ```sh
   terraform init
   ```  
2. **Validate the configuration**  
   ```sh
   terraform validate
   ```  
3. **Plan the deployment**  
   ```sh
   terraform plan
   ```  
4. **Apply the configuration**  
   ```sh
   terraform apply
   ```  
5. **Retrieve the EC2 instance IP**  
   ```sh
   terraform output public_ip
   ```  

After verifying the instance, you can clean up resources using:  
```sh
terraform destroy
```  

This project serves as a foundation for managing AWS infrastructure using Terraform, with a structured approach to variables and outputs for better maintainability.
