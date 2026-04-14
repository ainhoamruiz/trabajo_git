#
# Cookbook:: base_config
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.

# Actualizar el sistema (Apt update)
execute 'apt-get update' do
  command 'apt-get update'
end

# Instalar herramientas básicas
package ['vim', 'curl', 'git', 'unzip'] do
  action :install
end

# Configurar SSH (Paso 9 del proyecto: seguridad)
service 'ssh' do
  action [:enable, :start]
end

package 'snmpd' do
  action :install
end

service 'snmpd' do
  action [:enable, :start]
end