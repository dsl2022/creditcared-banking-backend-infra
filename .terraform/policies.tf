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