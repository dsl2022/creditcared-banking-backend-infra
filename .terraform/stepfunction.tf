
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

resource "aws_sfn_state_machine" "credit_card_application_state_machine" {
  name     = "creditcard-application"
  role_arn = aws_iam_role.step_function_role.arn
  definition = file("${path.module}/../templates/credit-card-app-stfn-def.json")

  type = "STANDARD"
}
