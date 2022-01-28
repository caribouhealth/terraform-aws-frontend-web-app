variable "environment" {
  description = "ie. development, release, or production"
}

variable "tags" {
  type        = map(any)
  description = "Tags that will be applied to every AWS resource which supports tags"
  default     = {}
}

variable "aws_hosted_zone_id" {
  description = "ID of AWS Route53 hosted zone"
}


variable "host_name" {
  description = "e.g. 'my-web-app.caribou.care'. if the domain is www, it will also register the root (apex) domain"
}

variable "name" {
  description = "Will be used as bucket prefix and in S3 origin ID. e.g. `my-web-app`"
}
