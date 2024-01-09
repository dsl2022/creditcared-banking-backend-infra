resource "aws_lambda_event_source_mapping" "stream_event_mapping" {
  event_source_arn  = aws_dynamodb_table.table.stream_arn
  function_name     = aws_lambda_function.ddb_stream_processor.arn
  starting_position = "LATEST"
}
