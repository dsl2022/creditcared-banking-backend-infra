resource "aws_lambda_function" "ddb_stream_processor" {
  function_name = "ddb_stream_processor"
  handler       = "index.handler"
  runtime       = "nodejs16.x"
  role          = aws_iam_role.lambda_role.arn

  // Assume you have a ZIP file with your Lambda code
  filename      = "${path.module}/../.serverless/myLambdaFunction.zip"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_common_role"

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
