# Module Terraform detection-de-base

Ce module configure la journalisation centralisée dans la région Paris (`eu-west-3`) pour une organisation AWS. Il permet de mettre en place les services de sécurité et de conformité dans un environnement multi-comptes.

---

## Fonctionnalités

### Pour tous les comptes de l'organisation :
- Activation de **CloudTrail** (événements de gestion uniquement)
- Activation de **AWS Config**
- Activation de **Amazon Inspector**
- Activation de **AWS WAF** (uniquement pour les comptes avec des VPN tagués `webapp_exposed`)

### Pour le compte de sécurité :
- Création d’un **bucket S3 sécurisé** pour stocker les logs CloudTrail
- Activation de **GuardDuty** pour surveiller le bucket S3
- Rapatriement des logs **GuardDuty** dans **Security Hub**
- Intégration des autres services dans **Security Hub**
- Cycle de vie des logs CloudTrail : 90 jours

---

## Variables

| Nom                      | Type         | Description                                           |
|--------------------------|--------------|-------------------------------------------------------|
| `region`                 | string       | Région AWS où déployer les ressources (`eu-west-3`)   |
| `security_bucket_name`   | string       | Nom du bucket S3 dans le compte sécurité              |
| `security_account_id`    | string       | ID du compte AWS de sécurité                          |
| `organization_account_ids` | list(string) | Liste des IDs des comptes de l'organisation         |

---

## Outputs

NomDescriptioncloudtrail_bucket_arnARN du bucket S3 CloudTrail| `cloudtrail_trail_name`  | Nom du trail CloudTrail                     |
| `guardduty_detector_id`  | ID du détecteur GuardDuty                   |

---

## Exemple d'utilisation


module "centralized_logging" {
  source                  = "../../modules/centralized_logging"
  region                  = "eu-west-3"
  security_bucket_name    = "overnis-security-cloudtrail-logs"
  security_account_id     = "123456789012"
  organization_account_ids = ["111111111111", "222222222222"]
}
