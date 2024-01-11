resource "aws_dynamodb_table" "table" {
  name           = "core-res-ddb"
  hash_key       = "accountToken"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "accountToken"
    type = "S"
  }
  attribute {
    name = "annualIncome"
    type = "S"
  }
   global_secondary_index {
    name               = "AnnualIncome"
    hash_key           = "annualIncome"
    projection_type    = "ALL"
    read_capacity      = 10
    write_capacity     = 10
  }
}
