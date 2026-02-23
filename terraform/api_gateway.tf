# ============================================
# API Gateway (using reusable module)
# ============================================

resource "aws_api_gateway_account" "api_gateway_account" {
  cloudwatch_role_arn = aws_iam_role.api_gateway_cloudwatch.arn
}

locals {
  user_endpoints = [for l in local.user_lambdas : {
    name = l.name, path_part = l.path_part, http_method = l.http_method,
    invoke_arn = aws_lambda_function.user[l.name].invoke_arn
  }]

  workout_endpoints = [for l in local.workout_lambdas : {
    name = l.name, path_part = l.path_part, http_method = l.http_method,
    invoke_arn = aws_lambda_function.workout[l.name].invoke_arn
  }]

  feed_endpoints = [for l in local.feed_lambdas : {
    name = l.name, path_part = l.path_part, http_method = l.http_method,
    invoke_arn = aws_lambda_function.feed[l.name].invoke_arn
  }]

  friends_endpoints = [for l in local.friends_lambdas : {
    name = l.name, path_part = l.path_part, http_method = l.http_method,
    invoke_arn = aws_lambda_function.friends[l.name].invoke_arn
  }]

  prs_endpoints = [for l in local.prs_lambdas : {
    name = l.name, path_part = l.path_part, http_method = l.http_method,
    invoke_arn = aws_lambda_function.prs[l.name].invoke_arn
  }]

  exercises_endpoints = [for l in local.exercises_lambdas : {
    name = l.name, path_part = l.path_part, http_method = l.http_method,
    invoke_arn = aws_lambda_function.exercises[l.name].invoke_arn
  }]
}

module "api_gateway" {
  source = "github.com/domgiordano/api-gateway-service"

  app_name = var.app_name

  services = {
    user = {
      path_prefix = "user"
      endpoints   = local.user_endpoints
    }
    workout = {
      path_prefix = "workout"
      endpoints   = local.workout_endpoints
    }
    feed = {
      path_prefix = "feed"
      endpoints   = local.feed_endpoints
    }
    friends = {
      path_prefix = "friends"
      endpoints   = local.friends_endpoints
    }
    prs = {
      path_prefix = "prs"
      endpoints   = local.prs_endpoints
    }
    exercises = {
      path_prefix = "exercises"
      endpoints   = local.exercises_endpoints
    }
  }

  authorization         = "CUSTOM"
  authorizer_invoke_arn = aws_lambda_function.authorizer.invoke_arn
  authorizer_role_arn   = aws_iam_role.authorizer_role.arn

  domain_name     = var.domain_name
  certificate_arn = var.certificate_arn

  allow_origin = "*"

  tags = local.standard_tags
}
