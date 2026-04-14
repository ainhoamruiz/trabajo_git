name "web_server"
description "Servidor Apache"
run_list "role[base_config]", "recipe[apache2]"