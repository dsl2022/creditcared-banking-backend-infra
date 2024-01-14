#IAM Role for lambdas
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


# step function role

resource "aws_iam_role" "step_function_role" {
  name = "step_function_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "states.us-east-1.amazonaws.com"
        }
      },
    ]
  })
}


# IAM Role for AppSync
resource "aws_iam_role" "appsync_iam_role" {
  name = "core-appsync-access-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "appsync.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "appsync_dynamodb_policy" {
  role       = aws_iam_role.appsync_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess" # Adjust as needed
}