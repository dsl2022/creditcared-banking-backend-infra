resource "aws_appsync_resolver" "add_customer_validation" {
  type   = "Mutation"
  api_id = aws_appsync_graphql_api.core_api.id
  field  = "applyForCreditCard"
  kind   = "PIPELINE"
#   runtime {
#     name            = "APPSYNC_JS"
#     runtime_version = "1.0.0"
#   }

  pipeline_config {
    functions = [
      aws_appsync_function.add_customer_validation.function_id,
    ]
  }
}

resource "aws_appsync_function" "add_customer_validation" {
  api_id      = aws_appsync_graphql_api.core_api.id
  data_source = aws_appsync_datasource.dynamodb_datasource.name
  name        = "add_customer_validation"
  code        = file("../src/appsync_functions/validationAddCustomer.js")

  runtime {
    name            = "APPSYNC_JS"
    runtime_version = "1.0.0"
  }
}