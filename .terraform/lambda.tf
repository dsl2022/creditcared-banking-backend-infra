data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../src/common"
  output_path = "${path.module}/../lambda_function.zip"
}

data "archive_file" "lambda_ddb_failed_stream_processor_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../src/utilities/core_ddb_failed_stream_processor"
  output_path = "${path.module}/../lambda_core_ddb_failed_stream_processor.zip"
}

resource "aws_lambda_function" "ddb_stream_processor" {
  function_name = "core_reso_stream_processor"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  role          = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

}

resource "aws_lambda_function" "core_ddb_failed_stream_processor" {
  function_name = "core_ddb_failed_stream_processor"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  role          = aws_iam_role.lambda_role.arn
  filename         = data.archive_file.lambda_ddb_failed_stream_processor_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_ddb_failed_stream_processor_zip.output_path)

}


resource "aws_cloudwatch_log_group" "lambda_stream_processor_log_group" {
  name = "/aws/lambda/${aws_lambda_function.ddb_stream_processor.function_name}"
  retention_in_days = 14
}

resource "aws_cloudwatch_log_group" "core_ddb_failed_stream_processor_log_group" {
  name = "/aws/lambda/${aws_lambda_function.core_ddb_failed_stream_processor.function_name}"
  retention_in_days = 14
}