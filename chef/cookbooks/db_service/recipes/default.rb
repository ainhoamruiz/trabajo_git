#
# Cookbook:: db_service
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.

package 'mariadb-server' do
  action :install
end

service 'mariadb' do
  action [:enable, :start]
end

# Crear la base de datos para el CMS
execute 'create_database' do
  command "mariadb -u root -e 'CREATE DATABASE IF NOT EXISTS cms_db;'"
  not_if "mariadb -u root -e 'SHOW DATABASES;' | grep cms_db"
end
