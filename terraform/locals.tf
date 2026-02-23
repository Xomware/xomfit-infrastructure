locals {
  standard_tags = {
    app         = var.app_name
    environment = var.environment
    managed_by  = "terraform"
  }

  lambda_variables = {
    APP_NAME       = var.app_name
    ENVIRONMENT    = var.environment
    USERS_TABLE    = aws_dynamodb_table.users.name
    WORKOUTS_TABLE = aws_dynamodb_table.workouts.name
    SOCIAL_TABLE   = aws_dynamodb_table.social.name
    FEED_TABLE     = aws_dynamodb_table.feed.name
    JWT_SECRET     = var.jwt_secret
    JWT_ISSUER     = var.app_name
    LOG_LEVEL      = var.environment == "prod" ? "WARNING" : "INFO"
  }

  # ── Lambda definitions ──────────────────────────
  user_lambdas = [
    { name = "create",  description = "Create user",         path_part = "create",  http_method = "POST" },
    { name = "data",    description = "Get user data",       path_part = "data",    http_method = "GET" },
    { name = "update",  description = "Update user",         path_part = "update",  http_method = "POST" },
    { name = "search",  description = "Search users",        path_part = "search",  http_method = "GET" },
  ]

  workout_lambdas = [
    { name = "create",  description = "Create workout",      path_part = "create",  http_method = "POST" },
    { name = "get",     description = "Get workout",         path_part = "get",     http_method = "GET" },
    { name = "list",    description = "List workouts",       path_part = "list",    http_method = "GET" },
    { name = "delete",  description = "Delete workout",      path_part = "delete",  http_method = "POST" },
  ]

  feed_lambdas = [
    { name = "get",     description = "Get feed",            path_part = "get",     http_method = "GET" },
    { name = "like",    description = "Like post",           path_part = "like",    http_method = "POST" },
    { name = "comment", description = "Comment on post",     path_part = "comment", http_method = "POST" },
  ]

  friends_lambdas = [
    { name = "request", description = "Send friend request", path_part = "request", http_method = "POST" },
    { name = "accept",  description = "Accept request",      path_part = "accept",  http_method = "POST" },
    { name = "reject",  description = "Reject request",      path_part = "reject",  http_method = "POST" },
    { name = "list",    description = "List friends",        path_part = "list",    http_method = "GET" },
    { name = "pending", description = "Pending requests",    path_part = "pending", http_method = "GET" },
    { name = "remove",  description = "Remove friend",       path_part = "remove",  http_method = "POST" },
  ]

  prs_lambdas = [
    { name = "list",    description = "List PRs",            path_part = "list",    http_method = "GET" },
  ]

  exercises_lambdas = [
    { name = "list",    description = "List exercises",      path_part = "list",    http_method = "GET" },
  ]
}
