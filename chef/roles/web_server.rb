name "web_server"
description "Frontales del CMS con Nginx o Apache"
run_list "role[base_config]", "recipe[nginx_service]"