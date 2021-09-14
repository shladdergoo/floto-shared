terraform {
  required_version = ">= 1.0.0"
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

module "lambda-ecr-repo" {
  source    = "./modules/lambda_ecr_repo"
  repo_name = "${var.app_name}-${var.note_processor_function_name}"
}

module "iam" {
  source                 = "./modules/iam"
  ci_service_user_name   = "${var.env}-${var.ci_service_user}"
  ci_service_policy_name = "${var.env}-${var.ci_service_policy}"
  tags                   = var.tags
}

output "ci-key" {
  value = module.iam.ci-key
}

output "ci-secret" {
  value     = module.iam.ci-secret
  sensitive = true
}
