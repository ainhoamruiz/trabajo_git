# 1. Actualizar el sistema
execute 'apt-get update' do
  command 'apt-get update'
end

# 2. Instalar herramientas básicas y monitorización
# Añadimos snmpd 
package ['vim', 'curl', 'git', 'unzip', 'snmpd'] do
  action :install
end

# 3. Configurar y asegurar SSH 
service 'ssh' do
  action [:enable, :start]
end

# 4. Habilitar el agente de monitorización
service 'snmpd' do
  action [:enable, :start]
end