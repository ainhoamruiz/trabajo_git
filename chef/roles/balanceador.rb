{
  "name": "balanceador",
  "run_list": [
    "role[base]",
    "recipe[nginx_service]"
  ]
}