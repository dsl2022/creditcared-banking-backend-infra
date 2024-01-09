module "appsync" {
  source = "./modules/appsync"
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "lambda" {
  source = "./modules/lambda"
}

module "sqs" {
  source = "./modules/sqs"
}
