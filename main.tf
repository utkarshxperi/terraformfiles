provider "aws" {
  region = "ap-south-1"
  access_key = "AKIAVOANXWL6VOJQXWUY"
  secret_key = "EdrV7SxNr+oZRSzqWPToC33L4cEEBpWWqNoK6JZz"
}



locals {
  repo_name = "terraformscripts2"
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "git clone git@github.com:utkarshxperi/${local.repo_name}.git"
  }
}

locals {
  files = fileset("${path.module}/${local.repo_name}", "**/*")
}

resource "aws_s3_object" "example" {
  for_each = local.files

  bucket = "gitpushdev"
  key = "${local.repo_name}/${each.value}"
  source = "${path.module}/${local.repo_name}/${each.value}"
}
