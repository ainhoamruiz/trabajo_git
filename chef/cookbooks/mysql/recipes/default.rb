#
# Cookbook:: mysql
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.
package 'mysql-server'

service 'mysql' do
  action [:enable, :start]
end