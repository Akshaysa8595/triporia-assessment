module "network" {
  source = "../../modules/network"

  vpc_cidr    = var.vpc_cidr
  environment = var.environment

  public_subnet_a_cidr = var.public_subnet_a_cidr
  public_subnet_b_cidr = var.public_subnet_b_cidr

  private_app_subnet_a_cidr = var.private_app_subnet_a_cidr
  private_app_subnet_b_cidr = var.private_app_subnet_b_cidr

  private_db_subnet_a_cidr = var.private_db_subnet_a_cidr
  private_db_subnet_b_cidr = var.private_db_subnet_b_cidr

  az1 = var.az1
  az2 = var.az2
}

module "security_groups" {
  source = "../../modules/security_groups"

  vpc_id = module.network.vpc_id
}

module "rds" {
  source = "../../modules/rds"

  private_db_subnet_ids = module.network.private_db_subnet_ids
  rds_sg_id             = module.security_groups.rds_sg_id

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
}
module "ecs" {
  source = "../../modules/ecs"

  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids

  alb_sg_id = module.security_groups.alb_sg_id
  ecs_sg_id = module.security_groups.ecs_sg_id
}
