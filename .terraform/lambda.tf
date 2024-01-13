data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../src/common"
  output_path = "${path.module}/../lambda_function.zip"
}

resource "aws_lambda_function" "ddb_stream_processor" {
  function_name = "core_reso_stream_processor"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  role          = aws_iam_role.lambda_role.arn

  // Assume you have a ZIP file with your Lambda code
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

}

resource "aws_iam_role" "lambda_role" {
  name = "core_common_reso_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy" "lambda_logging" {
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
    ]
  })
}

resource "aws_cloudwatch_log_group" "lambda_stream_processor_log_group" {
  name = "/aws/lambda/${aws_lambda_function.ddb_stream_processor.function_name}"
  retention_in_days = 14
}
