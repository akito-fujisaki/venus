locals {
  app = "venus"
  env = "sandbox"

  default_tags = {
    App = local.app
    Env = local.env
  }
}
