resource "random_id" "bucket_suffix" {
  byte_length = 4
}
resource "aws_instance" "web_server" {
  ami           = "ami-0c0292c4186d3d1ec"
  instance_type = "t2.micro"

   lifecycle {
    replace_triggered_by = [ aws_s3_bucket.example ]
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-critical-production-data1-${random_id.bucket_suffix.hex}"


}