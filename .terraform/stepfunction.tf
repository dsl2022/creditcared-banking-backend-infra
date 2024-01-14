resource "aws_sfn_state_machine" "credit_card_application_state_machine" {
  name     = "creditcard-application"
  role_arn = aws_iam_role.step_function_role.arn
  definition = templatefile("${path.module}/../templates/credit-card-app-stfn-def.json",{
    ValidateApplicationQueue = "${aws_sqs_queue.validate-application.url}"
    CheckIdentityQueue = "${aws_sqs_queue.check-identity.url}"
    CheckCreditScoreQueue = "${aws_sqs_queue.check-credit-score.url}"
    DecisioningQueue = "${aws_sqs_queue.decisioning.url}"
    NotifyApplicantQueue = "${aws_sqs_queue.notify-applicant.url}"
  })

  type = "STANDARD"
}
