terraform {
  backend "s3" {
    bucket = "huyy-tfstate-375649924539"
    key    = "tmp-github.tfstate"
    region = "us-east-1"
  }
}
