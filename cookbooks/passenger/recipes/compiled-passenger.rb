include_recipe 'passenger::passenger-dependencies'
gem_package "passenger" do
  gem_binary node[:passenger][:compiled][:gem_path]
  action :install
  version node[:passenger][:version]
end

execute "install-passenger" do
  command "#{node[:passenger][:compiled][:install_binary]} -a"
  not_if "test -f #{node[:passenger][:compiled][:module]}"
end

template "#{node[:apache][:dir]}/mods-available/passenger.load" do
  source "mods/passenger.load.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( :passengermodule => node[:passenger][:compiled][:module] )
end

options = {
  :passengerroot => node[:passenger][:compiled][:passengerroot],
  :passengerruby => node[:passenger][:compiled][:passengerruby],
  :passengermaxpoolsize => node[:passenger][:passengermaxpoolsize],
  :passengermaxrequests => node[:passenger][:passengermaxrequests] }

apache_module "passenger" do
  conf true
  module_options options
end
