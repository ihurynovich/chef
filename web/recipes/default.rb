#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "nginx.repo" do
path "/etc/yum.repos.d/nginx.repo"
  owner 'root'
  group 'root'
end

web "web_server_install" do
  provider node[:web_server_type]
  action :install
end

#web "nginx_install" do
#  provider node[:web_server_type]
#  action :install
#end

web "web_server_start" do
  provider node[:web_server_type]
  action :start
end

web "web_server_stop" do
  provider node[:web_server_type]
  action :stop
end

web "nginx_setup" do
  provider :web_nginx
  action :setup_web_server
end

web "web_server_reload" do
  provider node[:web_server_type]
  action :reload
end
