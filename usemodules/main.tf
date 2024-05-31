module "create_vm" {
  source                     = "./../modules/vm"
  resource_group_name_prefix = "module-demo"
  instance_type              = "Standard_D2s_v3"
}
