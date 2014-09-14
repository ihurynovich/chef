# Recipe download, unpack and put application jar to Jboss deploy folder. Then restart Jboss.

jboss_home = node['jboss']['jboss_home']

remote_file "/tmp/testweb.zip" do
  source node['jboss']['jboss_app']
end

execute "unzip_app" do
  cwd "/tmp/"
  command "unzip testweb.zip -d #{jboss_home}/jboss/standalone/deployments/"
  not_if {::File.exists?("#{jboss_home}/jboss/standalone/deployments/testweb")}
  action :run
end

service "jboss" do
  action [:restart]
end
