name "base_config"
description "Configuracion base de seguridad y red"
run_list "recipe[apt]", "recipe[openssh]"