## Common Var ##
aws_region   = "ap-northeast-2"
project_name = "terraform"
env          = "test"

## S3 bucket ##
create_backend        = true
s3_backend_name       = "s3-backend-name"
s3_backend_versioning = "Enabled"
s3_backend_controls   = "ObjectWriter"

## DynamoDB ##
dynamodb_backend_name = "dynamo-backend-name"