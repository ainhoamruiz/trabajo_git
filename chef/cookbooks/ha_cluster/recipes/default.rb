# =================================================================
# Receta: ha_cluster::default
# Descripción: Instalación y configuración de Corosync + Pacemaker
# Puntos del proyecto: 2 (Cluster HA), 3 (BD SQL), 12 (Redundancia)
# =================================================================

# 1. Instalación de paquetes necesarios
['corosync', 'pacemaker', 'crmsh', 'resource-agents'].each do |pkg|
  package pkg do
    action :install
  end
end

# 2. Habilitar y arrancar servicios básicos
service 'corosync' do
  action [:enable, :start]
end

service 'pacemaker' do
  action [:enable, :start]
end

# 3. Desplegar la configuración de Corosync (Redundancia Punto 12)
# Esto usa la plantilla corosync.conf.erb que creamos antes
template '/etc/corosync/corosync.conf' do
  source 'corosync.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[corosync]', :immediately
end

# 4. Configuración de recursos del clúster (Failover Punto 2 y 3)
# Creamos la IP Virtual 10.10.10.20 y vinculamos el servicio MySQL
execute 'configurar_recursos_ha' do
  command <<-EOH
    # Configurar la IP Virtual (VIP) para la Base de Datos
    crm configure primitive p_mysql_vip ocf:heartbeat:IPaddr2 \
      params ip="10.10.10.20" cidr_netmask="24" \
      op monitor interval="30s"
    
    # Configurar el agente de MySQL
    crm configure primitive p_mysql_service ocf:heartbeat:mysql \
      params binary="/usr/bin/mysqld_safe" \
      op monitor interval="20s" timeout="40s"
    
    # Colocación: La IP y la BD deben estar SIEMPRE en el mismo nodo
    crm configure colocation cl_mysql_with_vip infinite: p_mysql_service p_mysql_vip
    
    # Orden: Primero se levanta la IP y luego la Base de Datos
    crm configure order or_vip_before_mysql mandatory: p_mysql_vip p_mysql_service
    
    # Evitar que los recursos "salten" de vuelta si el nodo original revive (opcional)
    crm configure rsc_defaults resource-stickiness=100
  EOH
  action :run
  # Solo se ejecuta si no existe ya la VIP en el clúster
  not_if "crm status | grep p_mysql_vip"
end
