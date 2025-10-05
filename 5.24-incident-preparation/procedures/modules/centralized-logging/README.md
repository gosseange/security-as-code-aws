# centralized_logging Terraform Module

Ce module configure la journalisation centralisée dans une région AWS pour une organisation. Il inclut :

- Un bucket S3 sécurisé pour stocker les logs CloudTrail
- Un trail CloudTrail organisationnel régional (événements de gestion uniquement, sans data events S3)
- DNS logs activés via `advanced_event_selector`
- GuardDuty activé uniquement dans le compte sécurité, surveillant :
  - CloudTrail logs
  - VPC Flow Logs
  - DNS logs
- Une politique de cycle de vie pour conserver les logs pendant 90 jours

## Variables

| Nom                   | Type   | Description                                           | Défaut       |
|-----------------------|--------|-------------------------------------------------------|--------------|
| `region`              | string | Région AWS où déployer les ressources                 | `"us-east-1"`|
| `security_bucket_name`| string | Nom du bucket S3 dans le compte sécurité              | *(obligatoire)* |
| `security_account_id` | string | ID du compte AWS de sécurité                          | *(obligatoire)* |

## Outputs

| Nom                      | Description                                 |
|--------------------------|---------------------------------------------|
| `cloudtrail_bucket_arn`  | ARN du bucket S3 CloudTrail                 |
| `cloudtrail_trail_name`  | Nom du trail CloudTrail                     |
| `guardduty_detector_id`  | ID du détecteur GuardDuty                   |

## Exemple d'utilisation


module "centralized_logging" {
  source               = "../../modules/centralized_logging"
  region               = "ca-central-1"
  security_bucket_name = "overnis-security-cloudtrail-logs"
  security_account_id  = "123456789012"
}
