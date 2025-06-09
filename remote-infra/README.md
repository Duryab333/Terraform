
# Terraform Remote Backend Setup

This Terraform project configures remote state management using **AWS S3** and **DynamoDB**. Remote backends are essential for collaboration and maintaining consistent infrastructure state across teams or CI/CD pipelines.


## 🔧 What This Does

- Stores the Terraform state file (`terraform.tfstate`) in an **S3 bucket**
- Uses a **DynamoDB table** for state locking and consistency
- Sets up a secure and centralized state management solution

---

## 📁 Files Overview

- `provider.tf` – Configures the AWS provider
- `s3.tf` – Declares the S3 bucket used for remote backend
- `dynamodb.tf` – Creates a DynamoDB table for state locking
- `terraform.tf` – Backend block to enable remote state storage

---

## 🚀 How to Use

1. **Create the S3 bucket and DynamoDB table**  
   These must exist **before** initializing the backend.

2. **Initialize Terraform**  
   Connects to the remote backend:
   ```bash
   terraform init
   ```

3. **Deploy infrastructure**
   ```bash
   terraform plan
   terraform apply
   ```

---

## 📝 Notes

- Make sure AWS credentials have access to S3 and DynamoDB.
- The S3 bucket must have versioning enabled.
- DynamoDB ensures **only one user** modifies the state at a time.

---

## ✅ Example Backend Config

```hcl
terraform {
  backend "s3" {
    bucket         = "your-state-bucket-name"
    key            = "remote-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```
