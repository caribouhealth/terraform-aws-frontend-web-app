# terraform-aws-frontend-webapp

A terraform module to host a front-end SPA, provisioning the following:

- S3 bucket hosting, with public read permissions set
- Cloudfront, configured to serve the S3 bucket contents as a web app
- An SSL certificate, with automated validation against the provided hosted zone (domain hosted by AWS)
- A subdomain on the provided hosted, either configured explicitly by a variable, or auto-generated with a `-${var.environment}` postfix

## Releasing a new version
