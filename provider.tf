provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "Acces key of the AWS account"
  // Uncomment next line if you wish to use a default access key
  //default = "REPLACE-WITH-YOUR-ACCESS-KEY"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "Secret key of the AWS account"
  // Uncomment next line if you wish to use a default secret
  //default = "REPLACE-WITH-YOUR-SECRET"
}
