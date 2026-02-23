variable "app_name" {
  description = "Application name"
  type        = string
  default     = "xomfit"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "python3.12"
}

variable "lambda_memory_size" {
  description = "Lambda memory size in MB"
  type        = number
  default     = 256
}

variable "lambda_timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 30
}

variable "lambda_trace_mode" {
  description = "X-Ray tracing mode"
  type        = string
  default     = "Active"
}

variable "jwt_secret" {
  description = "JWT secret for authorizer"
  type        = string
  sensitive   = true
  default     = ""
}

variable "domain_name" {
  description = "Custom API domain (e.g., api.xomfit.com)"
  type        = string
  default     = ""
}

variable "certificate_arn" {
  description = "ACM certificate ARN for custom domain"
  type        = string
  default     = ""
}
