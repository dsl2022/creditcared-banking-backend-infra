resource "aws_appsync_datasource" "dynamodb_datasource" {
  api_id = aws_appsync_graphql_api.api.id
  name   = "DynamoDBDataSource"
  type   = "AMAZON_DYNAMODB"

  dynamodb_config {
    table_name = aws_dynamodb_table.table.name
    use_caller_credentials = false
  }
}
