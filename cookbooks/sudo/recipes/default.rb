require_recipe 'users'

package "sudo" do
  action :upgrade
end

remote_file "/etc/sudoers" do
  source "sudoers"
  mode 0440
  owner "root"
  group "root"
end
