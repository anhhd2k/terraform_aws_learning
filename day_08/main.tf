resource "aws_s3_bucket" "s3_bucket" {
  count = length(var.bucket_name)
  bucket = var.bucket_name[count.index]
  
  tags = var.tags
}

resource "aws_s3_bucket" "s3_bucket_set" {
  for_each = var.bucket_name_set
  bucket = each.key
  
  tags = var.tags
}