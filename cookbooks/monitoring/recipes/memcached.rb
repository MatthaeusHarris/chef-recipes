include_recipe 'monitoring'

template "/etc/monit/conf.d/memcached.monitrc" do
  source "memcached.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, resources(:service => "monit")
end
