output "vpc_id" {
    value = module.vpc.vpc_id
}
output "tg" {
    value = module.lb.tg
}
output "inst_ids" {
    value = module.asg.inst_ids
}
output "db_endpoint"{
    value = module.db.db_endpoint
}
output "db_name"{
    value = module.db.db_name
}
output "db_port"{
    value = module.db.db_port
}
output "eip" {
    value = module.eip.eip
}
output "igw" {
    value = module.igw.igw
}
output "key" {
    value = module.key.key
}
output "lt" {
    value = module.lt.lt
}
output "nat"{
    value = module.nat.nat
}
output "pub_rt" {
  value = module.rt.pub_rt
}
output "pvt_rt" {
  value = module.rt.pvt_rt
}
output "sg" {
  value = module.sg.sg
}
output "sns"{
    value = module.sns.sns
}
output "subnets"{
    value = module.subnet.subnets
}

output "db_pass" {
  value = module.db.db_pass
  sensitive = true
}
output "usr_name" {
  value = module.db.usr_name
}
output "lb-dns" {
  value = module.lb.lb-dns
}