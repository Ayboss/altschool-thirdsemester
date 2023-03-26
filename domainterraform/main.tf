terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
  }
}
//Use the Linode Provider
provider "linode" {
  token = var.token
}


# another