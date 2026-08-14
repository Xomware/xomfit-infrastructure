# ============================================
# DynamoDB Tables
# ============================================

resource "aws_dynamodb_table" "users" {
  deletion_protection_enabled = true

  point_in_time_recovery {
    enabled = true
  }
  name         = "${var.app_name}-users"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  tags = merge(local.standard_tags, { table = "users" })
}

resource "aws_dynamodb_table" "workouts" {
  deletion_protection_enabled = true

  point_in_time_recovery {
    enabled = true
  }
  name         = "${var.app_name}-workouts"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "workout_id"

  attribute {
    name = "workout_id"
    type = "S"
  }

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "started_at"
    type = "S"
  }

  global_secondary_index {
    name            = "user_id-started_at-index"
    hash_key        = "user_id"
    range_key       = "started_at"
    projection_type = "ALL"
  }

  tags = merge(local.standard_tags, { table = "workouts" })
}

resource "aws_dynamodb_table" "social" {
  deletion_protection_enabled = true

  point_in_time_recovery {
    enabled = true
  }
  name         = "${var.app_name}-social"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"
  range_key    = "sk"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  tags = merge(local.standard_tags, { table = "social" })
}

resource "aws_dynamodb_table" "feed" {
  deletion_protection_enabled = true

  point_in_time_recovery {
    enabled = true
  }
  name         = "${var.app_name}-feed"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user_id"
  range_key    = "sk"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "sk"
    type = "S"
  }

  tags = merge(local.standard_tags, { table = "feed" })
}
