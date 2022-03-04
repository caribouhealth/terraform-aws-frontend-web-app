output "urls" {
  value = locals.host_names
}

# legacy
output "url" {
  value = locals.host_names[0]
}
