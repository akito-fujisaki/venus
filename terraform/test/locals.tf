locals {
  env     = "test"
  product = "venus"

  default_tags = {
    Product     = local.product
    Environment = local.env
  }
}
