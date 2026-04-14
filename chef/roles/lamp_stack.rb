name "lamp_stack"
description "Servidor completo LAMP"
run_list "role[web_server]", "role[db_server]"