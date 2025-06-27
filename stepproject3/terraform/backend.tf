terraform {
  backend "s3" {
    bucket = "webseekerbucket123"
    key    = "tf_backend/terraform.tfstate"
    region = "eu-central-1"
  }
}
# terraform {
#   backend "local" {
#     path = "terraform.tfstate"
#   }
# }
