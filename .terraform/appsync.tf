resource "aws_appsync_graphql_api" "api" {
  name   = "core-appsync"  
  schema = file("${path.module}/../schema/schema.graphql")
  authentication_type = "API_KEY"
}
