name "lamp_stack"
description "Instalación completa de Web + DB"
run_list "role[web_server]", "role[db_server]"