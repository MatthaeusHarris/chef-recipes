if node[:platform].eql?("ubuntu") && node[:platform_version].eql?("8.04") && node[:languages][:ruby][:target_cpu].eql?("i486")

  include_recipe 'apt::brightbox-rubyee'

  package "libruby-1.8" do
    action :upgrade
  end

  execute "install libruby1.8" do
    command "apt-get install -y -q libruby1.8"
    user "root"
    action :run
  end

else

include_recipe 'ruby'
include_recipe 'ree::ree_deps'

  if not File.exists?(node[:ree][:path]) || (File.exists?(node[:ree][:path]) && !File.directory?(node[:ree][:path]))
    directory node[:ree][:src_path] do
      owner "root"
      group "root"
      mode "0755"
      action :create
    end

    remote_file node[:ree][:tar_file] do
      source node[:ree][:url]
      mode "0755"
    end

    script "install_ree" do
      interpreter "bash"
      user "root"
      cwd node[:ree][:src_path]
      code <<-EOH
    tar -xvf #{node[:ree][:tar_file]}
    cd  #{node[:ree][:version]}
    ./installer --dont-install-useful-gems --auto #{node[:ree][:path]}
    EOH
    end

    link "/opt/ruby" do
      to node[:ree][:path]
      link_type :symbolic
    end
  end
end
