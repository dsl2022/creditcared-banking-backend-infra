resource "aws_iam_policy" "lambda_ddb_stream_policy" {
  name   = "lambda-ddb-stream-access"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetRecords",
        "dynamodb:GetShardIterator",
        "dynamodb:DescribeStream",
        "dynamodb:ListStreams"
      ],
      "Resource": "${aws_dynamodb_table.table.stream_arn}"
    }
  ]
}
EOF
}

# Attach the policy to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_ddb_stream_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_ddb_stream_policy.arn
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
          "logs:PutLogEvents",
        ],
        Effect = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
    ]
  })
}

# IAM policy for SQS access
resource "aws_iam_policy" "lambda_sqs_policy" {
  name   = "lambda-sqs-access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "sqs:*",
        ],
        Resource = "*" 
      }
    ]
  })
}

# IAM policy for SQS access
resource "aws_iam_policy" "lambda_dynamodb_policy" {
  name   = "lambda-ddb-access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "dynamodb:*",
        ],
        Resource = "*" 
      }
    ]
  })
}
# Attach the SQS policy to the Lambda execution role
resource "aws_iam_role_policy_attachment" "lambda_sqs_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_sqs_policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_dynamodb_policy.arn
}

# step function role
resource "aws_iam_role_policy" "step_function_policy" {
  name   = "step_function_execution_policy"
  role   = aws_iam_role.step_function_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueAttributes"
        ],
        Effect = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "states:SendTaskSuccess",
          "states:SendTaskFailure"
        ],
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}