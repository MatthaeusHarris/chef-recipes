package "glusterfs-server"

service "glusterfs-server" do
  action :start
end

directory node[:glusterfs][:export_directory] do
  recursive true
end

# This configuration installs a replicated glusterfs server
template "/etc/glusterfs/glusterfsd.vol" do
  source "glusterfsd.vol.erb"
  mode   "0644"
  owner  "root"
  group  "root"
  notifies :restart, resources(:service => "glusterfs-server")
end

