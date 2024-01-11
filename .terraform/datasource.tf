resource "aws_appsync_datasource" "dynamodb_datasource" {
  api_id = aws_appsync_graphql_api.core_api.id
  name   = "DynamoDBDataSource"
  type   = "AMAZON_DYNAMODB"
  service_role_arn = aws_iam_role.appsync_iam_role.arn
  dynamodb_config {
    table_name = aws_dynamodb_table.table.name
    use_caller_credentials = false
  }
}
