resource "aws_s3_bucket" "cloudtrail_bucket" {
  bucket = var.security_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "cloudtrail_lifecycle" {
  bucket = aws_s3_bucket.cloudtrail_bucket.id

  rule {
    id     = "expire-cloudtrail-logs"
    status = "Enabled"

    expiration {
      days = 90
    }

    filter {
      prefix = ""
    }
  }
}

resource "aws_cloudtrail" "main" {
  name                          = "centralized-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.cloudtrail_bucket.id
  include_global_service_events = true
  is_multi_region_trail         = false
  enable_log_file_validation    = true
  enable_logging                = true
  is_organization_trail         = true

  advanced_event_selector {
    name = "DNSLogsOnly"

    field_selector {
      field  = "eventCategory"
      equals = ["Dns"]
    }
  }
}

resource "aws_guardduty_detector" "main" {
  enable = true
}
