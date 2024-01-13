resource "aws_sqs_queue" "sqs_queue" {
  name = "example-sqs-queue"
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
