resource "aws_route53_record" "dns_record" {
  count   = length(local.host_names)
  zone_id = var.aws_hosted_zone_id
  name    = local.host_names[count.index]
  type    = "A"
  alias {
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    evaluate_target_health = false
  }
}
  