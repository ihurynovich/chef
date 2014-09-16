action :install do
  package "nginx" do
    action :install
  end
end

action :start do
  service "nginx" do
    action :start
  end
end

action :restart do
  service "nginx" do
    action :restart
  end
end

action :stop do
  service "nginx" do
    action :stop
  end
end

action :setup_web_server do
  template "/etc/nginx/conf.d/default.conf" do
    action :create
    source "default.conf.erb"
    variables(
      :listen_port => node[:listen_port]
    )
    cookbook 'web_nginx'
  end
end

action :start do
  service "nginx" do
    action :start
  end
end

action :reload do
  service "nginx" do
    action :reload
  end
end
