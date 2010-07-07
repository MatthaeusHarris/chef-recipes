include_recipe 'apt::brightbox-main'
package "libapache2-mod-passenger" do
  action :upgrade
  version node[:passenger][:version]
  only_if do
    node[:platform].eql?("ubuntu") && node[:platform_version].eql?("8.04") && node[:languages][:ruby][:target_cpu].eql?("i486")
  end
end

template "#{node[:apache][:dir]}/mods-available/passenger.load" do
  source "mods/passenger.load.erb"
  owner "root"
  group "root"
  mode "0644"
  variables( :passengermodule => node[:passenger][:brightbox][:module] )
end

options = {
  :passengerroot => node[:passenger][:brightbox][:passengerroot],
  :passengerruby => node[:passenger][:brightbox][:passengerruby],
 }

apache_module "passenger" do
  conf true
  module_options options
end
