provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

backend "s3" {
    bucket         = "eks-demo-s"     # Replace with your S3 bucket name
    key            = "terraform-state"     # Optionally, you can specify a custom key/path for the state file
    region         = "us-east-1"             # Specify the region where the S3 bucket is located
  }
}
