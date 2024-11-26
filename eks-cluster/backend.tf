terraform {
  backend "s3" {
    bucket = "jenkins-terraform-kubernetes-flaskapp-2024-v2"
    region = "ap-northeast-1"
    key    = "eks/terraform.tfstate"
  }
}