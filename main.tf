terraform {
  required_version = ">= 1.0.0"
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

resource "aws_ecr_repository" "note-processor-image-repo" {
  name                 = "${var.app_name}-${var.note_processor_function_name}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
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
