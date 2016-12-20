# Terraform cannot create a keypair for now
# We most manually generate a keypair in our AWS console and save that keypair in the ~/.ssh directory
# TODO: Allow user to input the key_name variable
variable "key_name" {
  default = "frontend"
}

# TODO: Do not use static credentials in authentication.
# Use the EC2 role method which uses the IAM profile.
variable "access_key" {
  default = "testing"
}

# TODO: Do not use static credentials in authentication.
# Use the EC2 role method which uses the IAM profile.
variable "secret_key" {
  default = "testing"
}

variable "aws_region" {
  default = "ap-southeast-2"
}

variable "aws_amis" {
  default = {
    ap-southeast-2 = "ami-88b182eb" # ubuntu 14LTS
    ap-southeast-2 = "ami-65a0eb5f"
    ap-southeast-2 = "ami-c91c3eaa" # with docker
  }
}
