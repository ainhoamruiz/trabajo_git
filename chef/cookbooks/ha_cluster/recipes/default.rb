# =================================================================
# Receta: ha_cluster::default
# Descripción: Instalación y configuración de Corosync + Pacemaker
# Puntos del proyecto: 2 (Cluster HA), 3 (BD SQL), 12 (Redundancia)
# =================================================================

# 1. Copiar e Instalar paquetes descargados localmente
nombres_paquetes = [
  'corosync_3.1.6-1ubuntu1_amd64.deb',
  'pacemaker_2.1.2-1ubuntu3_amd64.deb',
  'crmsh_4.3.1-1ubuntu2_all.deb',
  'resource-agents_1%3a4.7.0-1ubuntu7_all.deb'
]

nombres_paquetes.each do |deb_file|
  cookbook_file "/tmp/#{deb_file}" do
    source deb_file
    mode '0644'
  end
end

execute 'instalar_paquetes_locales' do
  command 'dpkg -i --force-all /tmp/*.deb || apt-get install -f -y'
  action :run
end

# 2. Desplegar la configuración de Corosync 
template '/etc/corosync/corosync.conf' do
  source 'corosync.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[corosync]', :immediately
end

# 3. Habilitar y arrancar servicios básicos
service 'corosync' do
  action [:enable]
end

service 'pacemaker' do
  action [:enable]
end

# 4. Generar el script de configuración de recursos del clúster
file '/tmp/configurar_cluster.sh' do
  content <<~EOF
    #!/bin/bash
    # Configurar la IP Virtual (VIP) para la Base de Datos
    crm configure primitive p_mysql_vip ocf:heartbeat:IPaddr2 params ip="10.10.10.20" cidr_netmask="24" op monitor interval="30s"

    # Configurar el agente de MySQL
    crm configure primitive p_mysql_service ocf:heartbeat:mysql params binary="/usr/bin/mysqld_safe" op monitor interval="20s" timeout="40s"

    # Colocación: La IP y la BD deben estar SIEMPRE en el mismo nodo
    crm configure colocation cl_mysql_with_vip infinite: p_mysql_service p_mysql_vip

    # Orden: Primero se levanta la IP y luego la Base de Datos
    crm configure order or_vip_before_mysql mandatory: p_mysql_vip p_mysql_service

    # Evitar que los recursos "salten" de vuelta
    crm configure rsc_defaults resource-stickiness=100
  EOF
  mode '0755'
  owner 'root'
  group 'root'
end
