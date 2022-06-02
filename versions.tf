terraform {
  required_version = ">= 0.13"

  required_providers {
    aws        = ">= 4.0"
    helm       = ">= 2.5, < 3.0"
    kubernetes = ">= 2.11, < 3.0.0"
  }
}
