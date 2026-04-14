name "balanceador"
description "Rol para el Balanceador de Carga en red Main"
run_list "role[base_config]", "recipe[nginx_service]"
# Aquí podrías añadir atributos para las IPs de los frontales más adelante