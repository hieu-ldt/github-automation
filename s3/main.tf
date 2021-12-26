data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "this" {
  bucket = "huyy-tfstate-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
  tags = {
    Name  = "huyy-tfstate-${data.aws_caller_identity.current.account_id}"
    Owner = "huyy"
  }
}

resource "aws_s3_bucket_object" "this" {
  for_each = var.list_s3_objects
  depends_on = [
    aws_s3_bucket.this,
  ]
  bucket = "huyy-tfstate-${data.aws_caller_identity.current.account_id}"
  key    = each.value
}
