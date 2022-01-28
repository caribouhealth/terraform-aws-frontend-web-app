resource "aws_acm_certificate" "cert" {
  # AWS requires that cloudfront-associated certificates
  # must be in the us-east-1 region
  # https://docs.aws.amazon.com/acm/latest/userguide/acm-regions.html
  provider                  = aws.us_east_1
  domain_name               = local.host_names[0]
  subject_alternative_names = slice(local.host_names, 1, length(local.host_names))
  validation_method         = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "cert_validation" {
  count = length(local.host_names)

  allow_overwrite = true
  name            = tolist(aws_acm_certificate.cert.domain_validation_options)[count.index].resource_record_name
  records         = [tolist(aws_acm_certificate.cert.domain_validation_options)[count.index].resource_record_value]
  type            = tolist(aws_acm_certificate.cert.domain_validation_options)[count.index].resource_record_type
  zone_id         = var.aws_hosted_zone_id
  ttl             = 60

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "cert_validation" {
  # AWS requires that cloudfront-associated certificates
  # must be in the us-east-1 region
  # https://docs.aws.amazon.com/acm/latest/userguide/acm-regions.html
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = aws_route53_record.cert_validation[*].fqdn
}
