include_recipe 'monitoring'

template "/etc/monit/conf.d/memcached.monitrc" do
  source "memcached.erb"
  owner "root"
  group "root"
  mode 0644
  variables(:ipaddress => node[:ipaddress],
            :port => node[:memcached][:port]
  )
  notifies :restart, resources(:service => "monit")
end


