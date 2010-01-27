include_recipe 'ruby'
include_recipe 'ree::ree_deps'

directory node[:ree][:src_path] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file node[:ree][:tar_file] do
  source node[:ree][:url]
  mode "0755"
  checksum node[:ree][:tar_checksum]
end

script "install_ree" do
  interpreter "bash"
  user "root"
  cwd node[:ree][:src_path]
  require 'pp'
  not_if "test -f #{node[:ree][:path]}/bin/ruby"
  code <<-EOH
    tar -xvf #{node[:ree][:tar_file]}
    cd  #{node[:ree][:version]}
    ./installer #{node[:ree][:configure_options]}
    EOH
end

link "/opt/ruby" do
  to node[:ree][:path]
  link_type :symbolic
  not_if "test -L /opt/ruby"
end

