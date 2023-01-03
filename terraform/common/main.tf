resource "aws_ecr_repository" "main" {
  name                 = "${local.product}-ecr-repository-main"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  tags = merge(local.default_tags, {
    Name = "${local.product}-ecr-repository-main"
  })
}

resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.main.name

  policy = jsonencode({
    rules: [
      {
        rulePriority: 1,
        description: "venus-ecr-lifecycle-policy-main",
        selection: {
          tagStatus: "any",
          countType: "imageCountMoreThan",
          countNumber: 2
        },
        action: {
          type: "expire"
        }
      }
    ]
  })
}
