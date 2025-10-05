variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "security_bucket_name" {
  description = "Name of the S3 bucket in the security account to store CloudTrail logs"
  type        = string
}

variable "security_account_id" {
  description = "AWS Account ID of the security account"
  type        = string
}
