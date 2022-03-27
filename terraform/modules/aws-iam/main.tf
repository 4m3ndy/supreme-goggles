locals {
  common_tags = {
    "managed-by"  = "terraform"
  }
}

resource "aws_iam_group" "group" {
  name = "${var.entity_name}-group"
}

resource "aws_iam_policy" "policy" {
  name        = "${var.entity_name}-policy"
  description = "${var.entity_name} policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = aws_iam_role.role.arn
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "attachment" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_user" "user" {
  name = "${var.entity_name}-user"
  tags = local.common_tags
}

resource "aws_iam_user_group_membership" "membership" {
  user   = aws_iam_user.user.name
  groups = [
    aws_iam_group.group.name
  ]
}

resource "aws_iam_role" "role" {
  name                 = "${var.entity_name}-role"
  description          = "${var.entity_name} role"
  max_session_duration = var.max_session_duration
  tags                 = local.common_tags

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AllowRoleAssumptionWithinSameAccount"
        Principal = {
          AWS = var.aws_account_id
        }
      },
    ]
  })
}