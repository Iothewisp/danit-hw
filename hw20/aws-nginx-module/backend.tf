terraform {
  backend "s3" {
    bucket                  = "terraform-state-danit-devops-8"
    key                     = "webseeker13/hw20.tfstate"
    region                  = "eu-central-1"
    encrypt                 = true
    skip_credentials_validation = true
    skip_metadata_api_check = true
  }
}
