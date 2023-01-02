locals {
  env     = "stg"
  product = "venus"

  default_tags = {
    Product     = local.product
    Environment = local.env
  }
}
