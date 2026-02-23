# Store secrets in SSM Parameter Store
resource "aws_ssm_parameter" "jwt_secret" {
  name  = "/${var.app_name}/jwt-secret"
  type  = "SecureString"
  value = var.jwt_secret != "" ? var.jwt_secret : "change-me-in-console"

  tags = local.standard_tags

  lifecycle {
    ignore_changes = [value]
  }
}
