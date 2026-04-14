name "db_server"
description "Servidor MySQL"
run_list "role[base_config]", "recipe[mysql]"