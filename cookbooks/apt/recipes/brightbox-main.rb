include_recipe "apt"

remote_file "/etc/apt/sources.list.d/brightbox.list" do
  source "brightbox.list"
  mode 0755
  owner "root"
  group "root"
  action :create
end

execute "add-key" do
  command "wget http://apt.brightbox.net/release.asc -O - | sudo apt-key add -"
  user "root"
  creates "/var/tmp/.add-brightbox-main-key"
  action :run
  notifies :run, resources(:execute => "apt-get update"), :immediately
end

file "/var/tmp/.add-brightbox-main-key"

