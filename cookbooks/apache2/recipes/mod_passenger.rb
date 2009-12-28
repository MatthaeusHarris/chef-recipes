if node[:platform].eql?("ubuntu") && node[:platform_version].eql?("8.04") && node[:languages][:ruby][:target_cpu].eql?("i486")

  include_recipe 'apt::brightbox-main'

  package "libapache2-mod-passenger" do
    action :install
    action :upgrade
  end


else

  include_recipe 'apache2::passenger-dependencies'

  gem_package "passenger" do
    gem_binary node[:passenger][:gem_path]
    action :install
    version node[:passenger][:version]
  end


  execute "install-passenger" do
    command "#{node[:passenger][:install_binary]} -a"
  end
end

template "#{node[:apache][:dir]}/mods-available/passenger.load" do
  source "mods/passenger.load.erb"
  owner "root"
  group "root"
  mode 0644
end

apache_module "passenger" do
  conf true
end





