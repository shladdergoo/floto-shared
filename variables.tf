variable "region" {
  default = "eu-west-1"
}

variable "env" {}

variable "tags" {}

variable "account_id" {}

variable "app_name" {
  default = "floto"
}

variable "note_processor_function_name" {
  default = "note-processor"
}

variable "ci_service_user" {
  default = "ci-service-user"
}

variable "ci_service_policy" {
  default = "ci-service-policy"
}
