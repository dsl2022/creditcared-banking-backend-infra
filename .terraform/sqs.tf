resource "aws_sqs_queue" "validate-application" {
  name = "validate-application"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.validate-application-dlq.arn}"
    maxReceiveCount     = 5 // Adjust based on your requirement
  })
  // Additional SQS configurations...
}

resource "aws_sqs_queue" "validate-application-dlq" {
  name = "validate-application-dlq"
}

resource "aws_sqs_queue" "check-identity" {
  name = "check-identity"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.check-identity-dlq.arn}"
    maxReceiveCount     = 5 // Adjust based on your requirement
  })
  // Additional SQS configurations...
}

resource "aws_sqs_queue" "check-identity-dlq" {
  name = "check-identity-dlq"
}

resource "aws_sqs_queue" "check-credit-score" {
  name = "check-credit-score"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.check-credit-score-dlq.arn}"
    maxReceiveCount     = 5 // Adjust based on your requirement
  })
  // Additional SQS configurations...
}

resource "aws_sqs_queue" "check-credit-score-dlq" {
  name = "check-credit-score-dlq"
}

resource "aws_sqs_queue" "decisioning" {
  name = "decisioning"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.decisioning-dlq.arn}"
    maxReceiveCount     = 5 // Adjust based on your requirement
  })
  // Additional SQS configurations...
}

resource "aws_sqs_queue" "decisioning-dlq" {
  name = "decisioning-dlq"
}

resource "aws_sqs_queue" "notify-applicant" {
  name = "notify-applicant"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.notify-applicant-dlq.arn}"
    maxReceiveCount     = 5 // Adjust based on your requirement
  })
  // Additional SQS configurations...
}

resource "aws_sqs_queue" "notify-applicant-dlq" {
  name = "notify-applicant-dlq"
}

resource "aws_sqs_queue" "stream-on-failure" {
  name = "stream-on-failure"
  redrive_policy = jsonencode({
    deadLetterTargetArn = "${aws_sqs_queue.stream-on-failure-dlq.arn}"
    maxReceiveCount     = 5 // Adjust based on your requirement
  })
  // Additional SQS configurations...
}

resource "aws_sqs_queue" "stream-on-failure-dlq" {
  name = "stream-on-failure-queue-dlq"
  // Additional DLQ configurations...
}


resource "aws_lambda_event_source_mapping" "sqs_mapping" {
  event_source_arn  = aws_sqs_queue.stream-on-failure.arn
  function_name     = aws_lambda_function.core_ddb_failed_stream_processor.arn
  enabled           = true

  // SQS to Lambda specific configurations
}
