terraform {
  source = "../../../modules/vm"

}
inputs = {
  instance_type = "Standard_D2s_v3"
  resource_group_name_prefix = "dev"
}
