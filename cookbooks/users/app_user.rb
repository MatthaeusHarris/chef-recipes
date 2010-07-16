define :app_user, :site_options => { } do
  include_recipe "ssh_keys"
  site_options=params[:site_options]

  package "libshadow-ruby1.8" do
    action :install
  end

  group site_options[:user]

  user site_options[:user] do
    comment "#{site_options[:user]} application user"
    home "/home/#{site_options[:user]}"
    shell "/bin/bash"
    password site_options[:password]
    supports :manage_home => true
    action :create
    gid site_options[:user]
  end

  directory "/home/#{site_options[:user]}/.ssh" do
    action :create
    owner site_options[:user]
    group site_options[:user]
    mode 0700
  end

  options={ :group => site_options[:user] }

  add_keys site_options[:user] do
    conf options
  end

  require_recipe "sudo"
end
