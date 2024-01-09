resource "aws_dynamodb_table" "table" {
  name           = "core-res-ddb"
  hash_key       = "id"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "id"
    type = "S"
  }
}
