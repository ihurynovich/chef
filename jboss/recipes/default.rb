#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2014
#
# All rights reserved
#

include_recipe 'java'

package "tar" do
  action :install
end

package "tar" do
  action :install
end

jboss_home = node['jboss']['jboss_home']

remote_file "#{jboss_home}/jboss.tar.gz" do
  source node['jboss']['dl_url']
end

execute "untar_jboss" do
  cwd node['jboss']['jboss_home']
  command "tar -xzf jboss.tar.gz"
  action :run
end  

link "#{jboss_home}/jboss" do
  to "#{jboss_home}/jboss-as-7.1.1.Final"
end  

jboss_user = node['jboss']['jboss_user']

user jboss_user do
  home "/home/jboss"
  shell "/bin/bash"
end

directory "#{jboss_home}/jboss" do
  owner jboss_user
  group jboss_user
  mode "0755"
  recursive true
end

execute "chown jboss" do
  cwd jboss_home  
  command "chown -RL #{jboss_user}.#{jboss_user} #{jboss_home}/jboss"
end

directory '/etc/jboss-as' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file "jboss-as.conf" do
  path "/etc/jboss-as/jboss-as.conf"
  owner 'root'
  group 'root'
end

cookbook_file "jboss-as-standalone.sh" do
  path "/etc/init.d/jboss"
  owner 'root'
  group 'root'
  mode 0755
end

service "jboss" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:start]
end

include_recipe 'jboss::deploy'
