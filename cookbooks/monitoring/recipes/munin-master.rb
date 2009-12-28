package "munin" do
  action :install
end

file "/etc/munin/munin.conf" do
  source "munin.conf"
  mode "0644"
  owner "root"
  group "root"
end
