variable "repo_name" {}

variable "mutability" {
  default = "MUTABLE"
}

variable "scan_on_push" {
  type = bool
  default = false
}
