#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014
#
# All rights reserved - Do Not Redistribute
#
if "#{node[:web_server_type]}"==('web_nginx')
cookbook_file "nginx.repo" do
path "/etc/yum.repos.d/nginx.repo"
  owner 'root'
  group 'root'
end
elsif "#{node[:web_server_type]}"==('web_apache')
  puts "Apache web server will be installed"
end

web "web_server_install" do
  provider node[:web_server_type]
  action :install
end

web "web_server_start" do
  provider node[:web_server_type]
  action :start
end

web "web_server_stop" do
  provider node[:web_server_type]
  action :stop
end

if "#{node[:web_server_type]}"==('web_nginx')
web "nginx_setup" do
  provider :web_nginx
  action :setup_web_server
end
elsif "#{node[:web_server_type]}"==('web_apache')
  puts "Apache web server is already set up"
end

web "web_server_reload" do
  provider node[:web_server_type]
  action :reload
end
