resource "aws_lambda_function" "authorizer" {
  function_name    = "${var.app_name}-authorizer"
  description      = "JWT token authorizer"
  filename         = "./templates/lambda_stub.zip"
  source_code_hash = filebase64sha256("./templates/lambda_stub.zip")
  handler          = "handler.handler"
  runtime          = var.lambda_runtime
  memory_size      = 128
  timeout          = 10
  role             = aws_iam_role.lambda_role.arn

  environment {
    variables = {
      JWT_SECRET = var.jwt_secret
      JWT_ISSUER = var.app_name
    }
  }

  tags = merge(local.standard_tags, { name = "${var.app_name}-authorizer", lambda_type = "authorizer" })

  lifecycle {
    ignore_changes = [filename, source_code_hash, layers]
  }
}

# IAM role for API Gateway to invoke the authorizer
resource "aws_iam_role" "authorizer_role" {
  name = "${var.app_name}-authorizer-invoke-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "apigateway.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy" "authorizer_invoke" {
  name = "${var.app_name}-authorizer-invoke"
  role = aws_iam_role.authorizer_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "lambda:InvokeFunction"
      Resource = aws_lambda_function.authorizer.arn
    }]
  })
}
