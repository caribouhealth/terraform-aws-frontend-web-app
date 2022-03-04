terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
      configuration_aliases = [aws.main, aws.us_east_1]
    }
  }
}

locals {
  host_names = concat(
    var.host_name != "" ? [var.host_name] : [],
    var.host_names,

    # legacy -- applies www to the host_name
    substr(var.host_name, 0, 4) == "www."
      ? [substr(var.host_name, 4, -1)]
      : []
  )
  s3_origin_id = "S3-${var.name}-${var.environment}"
}
