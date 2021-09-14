resource "aws_iam_user" "ci-service-user" {
  name = var.ci_service_user_name
  tags = var.tags
}

resource "aws_iam_access_key" "ci-service-user" {
  user = aws_iam_user.ci-service-user.name
}

resource "aws_iam_user_policy" "ci-service-policy" {
  name = var.ci_service_policy_name
  user = aws_iam_user.ci-service-user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid" : "ECRPullPolicy",
        "Effect" : "Allow",
        "Action" : [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "ECRPushPolicy",
        "Effect" : "Allow",
        "Action" : [
          "ecr:InitiateLayerUpload",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "ECRAuthPolicy",
        "Effect" : "Allow",
        "Action" : [
          "ecr:GetAuthorizationToken"
        ],
        "Resource" : "*"
      }
    ]
  })
}
