terraform {
  backend "s3" {
    bucket         = "danit-devops-tf-state"
    # Example
    #key            = "eks/terraform.tfstate"
    key            = 
    encrypt        = true
    # Example
    #dynamodb_table = "lock-tf-eks"
    dynamodb_table = 
    # dynamo key LockID
    # Params tekan from -backend-config when terraform init
    #region = 
    #profile = 
  }
}

