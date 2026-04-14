#
# Cookbook:: nginx_service
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end

service 'nginx' do
  action [:enable, :start]
end

# Aquí podrías añadir una lógica para que si es balanceador 
# copie una configuración y si es web otra.