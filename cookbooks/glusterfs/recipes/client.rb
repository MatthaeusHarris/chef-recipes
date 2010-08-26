package "glusterfs-client"

gluster_servers=search(:node,"role:glusterfs-server")

template "/etc/glusterfs/glusterfs.vol" do
  source "glusterfs.vol.erb"
  mode   "0644"
  owner  "root"
  group  "root"
  variables :servers => gluster_servers
end

directory node[:glusterfs][:client][:mount_directory] do
  recursive true
end

execute "add-fuse-to-modules" do
  command "echo fuse >> /etc/modules"
  user "root"
  creates "/var/tmp/.add-fuse-to-modules"
end

file "/var/tmp/.add-fuse-to-modules"

mount node[:glusterfs][:client][:mount_directory] do
  device "/etc/glusterfs/glusterfs.vol"
  fstype "glusterfs"
  action [:mount, :enable] #This add the mount to fstab
  options "defaults,_netdev"
  dump 0
  pass 0
end
