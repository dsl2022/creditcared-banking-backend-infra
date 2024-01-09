resource "aws_dynamodb_table" "table" {
  name           = "example-table"
  hash_key       = "id"
  stream_enabled = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "id"
    type = "S"
  }

  provisioned_throughput {
    read_capacity_units  = 1
    write_capacity_units = 1
  }
}
