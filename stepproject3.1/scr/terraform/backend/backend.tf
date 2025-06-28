terraform {
  backend "s3" {
    bucket = "webseekerbucket123"
    key    = "tf_backend/terraform.tfstate"
    region = "eu-central-1"
    tags = {
    Name        = "websesker bucket"
  }
}
# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }
