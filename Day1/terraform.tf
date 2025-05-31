terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
  backend "s3" {
  bucket=  "my-tf-backend-s3-bucket-myyy"
  dynamodb_table = "terraform-lock"
  key = "terraform.state"
  region = "us-east-1"

}
}

