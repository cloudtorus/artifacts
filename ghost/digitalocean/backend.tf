terraform {
  backend "s3" {
    skip_credentials_validation = true
    skip_metadata_api_check = true
    endpoint = "https://nyc3.digitaloceanspaces.com"
    key = "ghost.terraform.tfstate"
  }
}
