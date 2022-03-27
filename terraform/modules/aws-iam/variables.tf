variable "entity_name" {
  type        = string
  description = "Entity name"
  default     = "entity-name"
}

variable "aws_account_id" {
  type        = string
  description = "AWS Account ID"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "max_session_duration" {
  type        = string
  description = "Maximum session duration (in seconds) that you want to set for the specified role."
  default     = "14400"
}
