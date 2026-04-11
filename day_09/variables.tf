variable "tags" {
  type = map(string)
  default = {
    "Environment" = "sit"
    "owner"       = "curated"
  }
}

variable "region" {
  default = "ap-southeast-1"
  type    = string
}

variable "bucket_name" {
  type    = list(string)
  default = ["aws-bucket-anhhd1709-01", "aws-bucket-anhhd1709-02"]
}

variable "bucket_name_set" {
  type = set(string)
  default = [ "awasdfasfsafd-123","awasdfasfsafd-124"]
  
}