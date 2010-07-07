include_recipe 'passenger::passenger-dependencies'

gem_package "passenger" do
  gem_binary node[:passenger][:enterprise][:gem_path]
  version node[:passenger][:version]
end

execute "install-passenger" do
  command "#{node[:passenger][:enterprise][:install_binary]} -a"
  not_if "test -f #{node[:passenger][:enterprise][:module]}"
end

template "#{node[:apache][:dir]}/mods-available/passenger.load" do
  source "mods/passenger.load.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( :passengermodule => node[:passenger][:enterprise][:module] )
end

options = {
  :passengerroot => node[:passenger][:enterprise][:passengerroot],
  :passengerruby => node[:passenger][:enterprise][:passengerruby]}
apache_module "passenger" do
  conf true
end
