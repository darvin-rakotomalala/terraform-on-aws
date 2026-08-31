# Deploy a static website using S3 + CloudFront + OAC
module "site_prod" {
  source      = "./modules/static_site"
  bucket_name = var.bucket_name
  index_file  = abspath("${path.root}/index.html")
}

/*
# Multiple Environments
module "site_staging" {
  source      = "./modules/static_site"
  bucket_name = "my-staging-bucket"
  index_file  = "./staging/index.html"
}

module "site_prod" {
  source      = "./modules/static_site"
  bucket_name = "my-prod-bucket"
  index_file  = "./prod/index.html"
}
*/
