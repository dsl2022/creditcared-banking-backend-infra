resource "aws_sfn_state_machine" "credit_card_application_state_machine" {
  name     = "creditcard-application"
  role_arn = aws_iam_role.step_function_role.arn
  definition = file("${path.module}/../templates/credit-card-app-stfn-def.json")

  type = "STANDARD"
}
