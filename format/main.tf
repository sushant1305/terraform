locals {
  string1 = "str1"
  string2 = "str2"
  int1 =3
  apply_format1 = format("This is string one value %s", local.string1)
  apply_format2 = format("This is string one value %s_This is string two value %s_This is integer value %d", local.string1, local.string2, local.int1)
}

output "output1" {
  value = local.apply_format1
}

output "output2" {
  value = local.apply_format2
}
