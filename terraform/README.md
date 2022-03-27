# aws-iam
This Terraform module creates the following resources in IAM:
• A role, with no permissions, which can be assumed by users within the same account,
• A policy, allowing users / entities to assume the above role,
• A group, with the above policy attached,
• A user, belonging to the above group..

## Requirements
- terraofrm >= 1.1.0

## How to run
* Set the AWS credentials using `aws configure` under the profile name `default` in order to provision the required resources.

* Set the value of the required variables in the following terraform file `terraform/variables.tf`.

* Update/Set `terraform/variables.tf` with the required values

```
variable "entity_name" {
  description = "Value of the Name of the IAM Entity"
  type        = string
  default     = "prod-ci"
}

variable "aws_account_id" {
  description = "Value of the Name of the IAM Entity"
  type        = string
  default     = "999999999999"
}

variable "aws_region" {
  description = "Value of the Name of the IAM Entity"
  type        = string
  default     = "us-east-1"
}
```

* Run the following steps to initialize, plan and apply the required resources.

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

* After running the terraform scripts, you should be able to see the name and the ARNs of the provisioned resources:
```bash
Outputs:
group_arn = "arn:aws:iam::999999999999:group/prod-ci-group"
group_name = "prod-ci-group"

role_arn = "arn:aws:iam::999999999999:role/prod-ci-role"
role_name = "prod-ci-role"

user_arn = "arn:aws:iam::999999999999:user/prod-ci-user"
user_name = "prod-ci-user"
```

* To destroy the provisioned resources, run the following:
```
terraform destroy
```