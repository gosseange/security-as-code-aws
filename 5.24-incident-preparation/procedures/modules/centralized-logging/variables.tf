variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-3"
}

variable "security_bucket_name" {
  description = "Name of the S3 bucket in the security account to store CloudTrail logs"
  type        = string
}

variable "security_account_id" {
  description = "AWS Account ID of the security account"
  type        = string
}

variable "organization_account_ids" {
  description = "List of AWS Account IDs in the organization"
  type        = list(string)
}

variable "execution_date" {
  description = "Execution date for tagging resources"
  type        = string
}
