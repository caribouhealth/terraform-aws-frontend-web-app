resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.name}-${var.environment}"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = var.tags
}

data "aws_iam_policy_document" "s3_policy_document" {
  # Public GET access
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "S3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.s3_policy_document.json
}
