output "group_name" {
  value = aws_iam_group.group.name
}

output "group_arn" {
  value = aws_iam_group.group.arn
}

output "user_name" {
  value = aws_iam_user.user.name
}

output "user_arn" {
  value = aws_iam_user.user.arn
}

output "role_name" {
  value = aws_iam_role.role.name
}

output "role_arn" {
  value = aws_iam_role.role.arn
}