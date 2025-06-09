## Terraform State File

Terraform is an Infrastructure as Code (IaC) tool used to define and provision infrastructure resources. The state file, often named terraform.tfstate, helps Terraform track the resources it manages. This file contains details about the infrastructure's current state, such as resource attributes, dependencies, and metadata.

**Advantages:**
- Resource Tracking: Keeps track of all managed resources and their dependencies.

- Concurrency Control: Locks resources to prevent simultaneous modifications.

- Plan Calculation: Shows the difference between the desired configuration and the current state.

- Resource Metadata: Stores crucial metadata like unique identifiers.

**Disadvantages of Storing State in VCS:**
- Security Risks: Sensitive information may be exposed.

- Versioning Complexity: Can lead to complex versioning issues with multiple team members.


**Overcoming Disadvantages with Remote Backends (e.g., S3):**

A remote backend stores the Terraform state file outside of your local file system and version control. Using S3 as a remote backend is a popular choice due to its reliability and scalability.
And also using Use DynamoDB?

- State Locking: Prevents multiple users from running Terraform at the same time, avoiding conflicts.
- Concurrency Control: Ensures only one execution modifies the state file at a time

Here's how to set it up:


### S3 buckt creation
`main.tf` file 

```
provider "aws" {
    region = "us-east-1"
  
}

resource "aws_instance" "duryabinstance" {
    instance_type = "t2.micro"
    ami = "ami-04b4f1a9cf54c11d0"
    }

resource "aws_s3_bucket" "terraform-bucket" {
    bucket = "duryab-s3-demo"
  
}

resource "aws_dynamodb_table" "terraform_lock" {
    name = "terraform-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
      name = "LockID"
      type = "S"
      
    }
  
}

```

run 
```

terraform init
terraform plan
terraform apply

```
means first create the s3 bucket and dynamodb then write the backend file then again exeute with terraform init and all
then write the `backend.tf` file 

```
terraform {
  backend "s3" {
    bucket = "duryab-s3-demo"
    key = "duryab/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
   
  }
}
```


**Conclusion**

✅ S3 securely stores the Terraform state file.

✅ DynamoDB prevents multiple users from modifying the state at the same time.

✅ Terraform now has a reliable, scalable state management system.
