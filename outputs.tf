output "urls" {
  value = local.host_names
}

# legacy
output "url" {
  value = local.host_names[0]
}
