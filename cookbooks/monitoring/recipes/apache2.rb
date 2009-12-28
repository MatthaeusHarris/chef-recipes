include_recipe 'monitoring'

template "/etc/monit/conf.d/apache2.monitrc" do
  source "apache2.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "monit")
end
