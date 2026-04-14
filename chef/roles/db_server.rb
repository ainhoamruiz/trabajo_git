name "db_server"
description "Servidor de Base de Datos SQL"
run_list "role[base_config]", "recipe[db_service]"