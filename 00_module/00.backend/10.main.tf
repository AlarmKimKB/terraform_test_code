
resource "aws_s3_bucket" "s3_backend" {
  count       = var.create_backend ? 1 : 0

  bucket      = var.s3_backend_name

  tags = merge(
    local.default_tags, {
    Name = format("s3-backend-%s-%s", 
                  var.project_name, 
                  var.env)
  })
}

resource "aws_s3_bucket_versioning" "s3_backend_versioning" {
  count  = var.create_backend ? 1 : 0

  bucket = aws_s3_bucket.s3_backend[0].bucket
  versioning_configuration {
    status = var.s3_backend_versioning
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_backend_encrypt" {
  count  = var.create_backend ? 1 : 0

  bucket = aws_s3_bucket.s3_backend[0].bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "s3_backend_controls" {
  count  = var.create_backend ? 1 : 0

  bucket = aws_s3_bucket.s3_backend[0].bucket
  rule {
    object_ownership = var.s3_backend_controls
  }
}

resource "aws_s3_bucket_public_access_block" "s3_backend_access_block" {
  count  = var.create_backend ? 1 : 0

  bucket = aws_s3_bucket.s3_backend[0].bucket

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_dynamodb_table" "dynamodb_backend" {
  count        = var.create_backend ? 1 : 0

  name         = var.dynamodb_backend_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
