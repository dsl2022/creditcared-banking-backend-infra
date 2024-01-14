{
    "Comment": "A state machine for processing a credit card application with SQS and Lambda integration using the callback pattern.",
    "StartAt": "ValidateApplication",
    "States": {
      "ValidateApplication": {
        "Type": "Task",
        "Resource": "arn:aws:states:::sqs:sendMessage.waitForTaskToken",
        "Parameters": {
          "QueueUrl": "${ValidateApplicationQueue}",
          "MessageBody": {
            "Input.$": "$",
            "TaskToken.$": "$$.Task.Token"
          }
        },
        "Next": "CheckIdentity"
      },
      "CheckIdentity": {
        "Type": "Task",
        "Resource": "arn:aws:states:::sqs:sendMessage.waitForTaskToken",
        "Parameters": {
          "QueueUrl": "${CheckIdentityQueue}",
          "MessageBody": {
            "Input.$": "$",
            "TaskToken.$": "$$.Task.Token"
          }
        },
        "Next": "CheckCreditScore"
      },
      "CheckCreditScore": {
        "Type": "Task",
        "Resource": "arn:aws:states:::sqs:sendMessage.waitForTaskToken",
        "Parameters": {
          "QueueUrl": "${CheckCreditScoreQueue}",
          "MessageBody": {
            "Input.$": "$",
            "TaskToken.$": "$$.Task.Token"
          }
        },
        "Next": "Decisioning"
      },
      "Decisioning": {
        "Type": "Task",
        "Resource": "arn:aws:states:::sqs:sendMessage.waitForTaskToken",
        "Parameters": {
          "QueueUrl": "${DecisioningQueue}",
          "MessageBody": {
            "Input.$": "$",
            "TaskToken.$": "$$.Task.Token"
          }
        },
        "Next": "NotifyApplicant"
      },
      "NotifyApplicant": {
        "Type": "Task",
        "Resource": "arn:aws:states:::sqs:sendMessage.waitForTaskToken",
        "Parameters": {
          "QueueUrl": "${NotifyApplicantQueue}",
          "MessageBody": {
            "Input.$": "$",
            "TaskToken.$": "$$.Task.Token"
          }
        },
        "End": true
      }
    }
  }
  