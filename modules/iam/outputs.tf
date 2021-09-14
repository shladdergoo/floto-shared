output "ci-key" {
  value = aws_iam_access_key.ci-service-user.id
}

output "ci-secret" {
  value = aws_iam_access_key.ci-service-user.secret
}
