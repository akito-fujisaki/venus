resource "aws_ecr_repository" "backend" {
  name                 = "${local.app}-backend"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  tags = merge(local.default_tags, {
    Name = "${local.app}-backend"
  })
}

resource "aws_ecr_lifecycle_policy" "backend" {
  repository = aws_ecr_repository.backend.name

  policy = jsonencode({
    rules : [
      {
        rulePriority : 1,
        description : "venus-ecr-lifecycle-policy-main",
        selection : {
          tagStatus : "any",
          countType : "imageCountMoreThan",
          countNumber : 2
        },
        action : {
          type : "expire"
        }
      }
    ]
  })
}
