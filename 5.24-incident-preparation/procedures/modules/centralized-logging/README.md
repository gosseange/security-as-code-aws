# centralized_logging Terraform Module

This module sets up centralized logging in a single AWS region for an organization. It includes:

- A secure S3 bucket for storing CloudTrail logs
- A regional CloudTrail trail for management events only (no S3 data events)
- DNS logs enabled via advanced event selector
- GuardDuty enabled only in the security account, monitoring:
  - CloudTrail logs
  - VPC Flow Logs
  - DNS logs
- Lifecycle policy to retain logs for 90 days

## Variables

| Name         | Type   | Description                                  | Default      |
|--------------|--------|----------------------------------------------|--------------|
| region       | string | AWS region to deploy resources               | "us-east-1"  |
| bucket_name  | string | Name of the S3 bucket for CloudTrail logs    | (required)   |

## Outputs

NameDescriptioncloudtrail_bucket_arnARN of the CloudTrail S3 bucketcloudtrail_trail_nameName of the CloudTrail trail| guardduty_detector_id  | ID of the GuardDuty detector                |

## Example Usage


module "centralized_logging" {
  source      = "../../modules/centralized_logging"
  region      = "ca-central-1"
  bucket_name = "overnis-security-cloudtrail-logs"
}
