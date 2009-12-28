
package "munin-node" do
  action :install
end

template "/etc/munin/munin-node.conf" do
  source "munin-node.erb"
  mode "0644"
  owner "root"
  group "root"
end

extra = %w{ passenger_memory passenger_stats }

extra.each do |p|
  remote_file "/usr/share/munin/plugins/#{p}" do
    source p
    mode "0644"
  end
end


plugins = %w{ apache_accesses apache_processes apache_volume cpu df df_inode entropy forks if_err_eth0 if_err_eth1 if_eth0 if_eth1 interrupts iostat load memory mysql_queries netstat open_files open_inodes passenger_memory passenger_stats postfix_mailqueue postfix_mailvolume processes swap uptime vmstat }
uninstall = %w{ exim_mailqueue exim_mailstats irqstats ntp_europium_canonical_com }

plugins.each do |p|
  link "/etc/munin/plugins/#{p}" do
    to "/usr/share/munin/plugins/#{p}"
    link_type :symbolic
  end
end

uninstall.each do |p|
  link "/etc/munin/plugins/#{p}" do
    action :delete
    only_if "test -f /etc/munin/plugins/#{p}"
  end
end

service "munin-node" do
  # By default, the init provider is used, which runs /etc/init.d/service_name with _command.
  supports :restart => true, :reload => true
  action :restart
end

