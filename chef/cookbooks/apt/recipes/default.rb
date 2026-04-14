#
# Cookbook:: apt
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.
execute 'update apt' do
  command 'apt update'
end