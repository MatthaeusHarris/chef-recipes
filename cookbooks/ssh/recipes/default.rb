package "openssh-server"

service "ssh" do
  supports :reload => true
  action :nothing
  pattern "sshd"
  service_name "ssh"
end

remote_file "/etc/ssh/sshd_config" do
  source "sshd_config"
  mode "0644"
  owner "root"
  group "root"
  notifies :reload, resources(:service => "ssh")
end
