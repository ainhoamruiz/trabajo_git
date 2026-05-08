#
# Cookbook:: nginx_service
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.

# Ignoramos el fallo de instalación si no hay red
package 'nginx' do
  action :install
  ignore_failure true
end

service 'nginx' do
  action [:enable, :start]
end

# Aquí podrías añadir una lógica para que si es balanceador 
# copie una configuración y si es web otra.