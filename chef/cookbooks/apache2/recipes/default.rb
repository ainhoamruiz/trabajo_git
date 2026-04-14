#
# Cookbook:: apache2
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.
package 'apache2'

service 'apache2' do
  action [:enable, :start]
end