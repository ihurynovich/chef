# Recipe download, unpack and put application jar to Jboss deploy folder. Then restart Jboss.

jboss_home = node['jboss']['jboss_home']

remote_file "/tmp/hudson.zip" do
  source "#{node[:app_repo]}"
end

directory '/opt/jboss/standalone/deployments/hudson' do
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

bag = data_bag_item("jboss", "hudson")

template "/opt/jboss/standalone/deployments/hudson/hudson.xml" do
  source "hudson.xml.erb"
  variables :j => bag["name"]
end

execute "unzip_app" do
  cwd "/tmp/"
  command "unzip hudson.zip -d #{jboss_home}/jboss/standalone/deployments/"
  not_if {::File.exists?("#{jboss_home}/jboss/standalone/deployments/hudson")}
  action :run
end

service "jboss" do
  action [:restart]
end
