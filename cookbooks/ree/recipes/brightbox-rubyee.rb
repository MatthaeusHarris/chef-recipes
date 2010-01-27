  include_recipe 'apt::brightbox-rubyee'

  package "libruby-1.8" do
    action :upgrade
  end

  execute "install libruby1.8" do
    command "apt-get install -y -q libruby1.8"
    user "root"
    action :run
  end

