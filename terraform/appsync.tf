resource "aws_appsync_graphql_api" "api" {
  name   = "example"
  schema = file("${path.module}/schema.graphql")

  authentication_type = "API_KEY"
}
