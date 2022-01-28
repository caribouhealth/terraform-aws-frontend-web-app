terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
    }
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

locals {
  host_names = substr(var.host_name, 0, 4) == "www." ? [var.host_name, substr(var.host_name, 4, -1)] : [var.host_name]
  s3_origin_id = "S3-${var.name}-${var.environment}"
}
