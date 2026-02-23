resource "aws_lambda_function" "user" {
  for_each         = { for l in local.user_lambdas : l.name => l }
  function_name    = "${var.app_name}-user-${each.value.name}"
  description      = each.value.description
  filename         = "./templates/lambda_stub.zip"
  source_code_hash = filebase64sha256("./templates/lambda_stub.zip")
  handler          = "handler.handler"
  runtime          = var.lambda_runtime
  memory_size      = var.lambda_memory_size
  timeout          = var.lambda_timeout
  role             = aws_iam_role.lambda_role.arn

  environment {
    variables = local.lambda_variables
  }

  tracing_config {
    mode = var.lambda_trace_mode
  }

  tags = merge(local.standard_tags, { name = "${var.app_name}-user-${each.value.name}", lambda_type = "user" })

  lifecycle {
    ignore_changes = [filename, source_code_hash, layers]
  }
}
