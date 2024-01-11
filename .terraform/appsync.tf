resource "aws_appsync_graphql_api" "core_api" {
  name   = "core-b-appsync"  
  schema = file("${path.module}/../schema/schema.graphql")
  authentication_type = "API_KEY"
}
