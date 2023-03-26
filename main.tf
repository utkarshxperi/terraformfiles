provider "aws" {
  region = "us-east-1"
  access_key = "ASIA4KLJSGBEHDO6VLXS"
  secret_key = "MmxQhEWUm0HV86JcVpJcIjPXoO3xaFXUeyRCkxtQ"
  token= "IQoJb3JpZ2luX2VjEDcaCXVzLXdlc3QtMiJHMEUCIGyQwU5EI7jhBBWIUA/kjtn/5z5ukS0PR+u1gaidUPV0AiEAqLYVgd1Zxr5BKJjGP7oTGmlEb5LUlgd2WWynUBYf6z8qjwMIEBAFGgw4NDY4NjY4MjExOTIiDEOsDyR+lnsRbcqbACrsAuLKOSEB9cpYQKtxo3WuOPQBZyI79BQwiUyJWaGAaWUM24oJFw+lzEl+zXCLiv/P1/kIrv+98nsafXmjZih5Fh01n9bZdojYwenJseUzwq4OMxCi0+q/umAltWBtuKq5IY1y+4IL0Es0smporOBGTYVMreK6bf+uNhrI21lmeuCla+p4WZNIligwNR4mZS8xOwi6VTY/l2NYnhkvWB9eS11TpyoHPf2K3XINTkSzYemn9RkKi0r3/fMkp8X9sY9zWyq99nmBIvRgo0pMs5cTixZbKGSPLiwHlbrRQCjiZayVIeLwEyGGNs4QWhyYYzUvnRU9yva1AZPZAyuAxO1tnBO1uQN983qnVEq0Fu2YyIlhw5hKxhDTJaaZoH72456N0wU5Uc/yvtw9+Ei5tJgBHIXjjZs2gPEG9YH63SCs1pVlYfJrcCu5jqygXoH/LVfQNLReg+DUFtnzSJqdwBeHOeY2DmXWSyOwRNPHSesw29P/oAY6pgHk+m475nJV4w4F/rNWJGfuZUPswDGIZFWLSzqkD0wGhHV0JHCqZ3a/FYqXrip6FqCvwOqkxiOexG4x5ZBsAyjiXll0KGUK5pSXTkFl/8P40+hTZDUDoFZJX/sHg195dwiwqOqdsr2/MllBUo8Y4q2nP3cOwUcymonBl+i2YApH02Qbzgd/EVz5j+J6Z5Rc0Z6Wlm5lwMXxUeRCC0dArAn9VJO4gKLu"

}

locals {
  repo_name = "tivo-chromecast-reciever-app"
}

resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "git clone git@github.com:tivocorp/${local.repo_name}.git"
  }
}

locals {
  files = fileset("${path.module}/${local.repo_name}/src", "**/*")
}

resource "aws_s3_object" "example" {
  for_each = local.files
         
  bucket = "chromecast-mobile"
  key = "utkarsh/${each.value}"
  source = "${path.module}/${local.repo_name}/src/${each.value}"
}
