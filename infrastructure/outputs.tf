#outputs.tf
output "Bastion public IP" { value = "${module.bastion.bastion_ip}" }
output "Memcached private IPs" { value = "${module.cache.memcached_ips}" }
