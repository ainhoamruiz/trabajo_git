#
# Cookbook:: openssh
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.
package 'openssh-server'

service 'ssh' do
  action [:enable, :start]
end