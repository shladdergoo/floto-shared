resource "aws_ecr_repository" "ecr-repo" {
  name                 = var.repo_name
  image_tag_mutability = var.mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

resource "aws_ecr_repository_policy" "lambda-ecr-repo-policy" {
  repository = aws_ecr_repository.ecr-repo.name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Sid" : "LambdaECRImageRetrievalPolicy",
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "lambda.amazonaws.com"
      },
      "Action" : [
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer"
      ]
    }]
  })
}
