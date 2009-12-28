  remote_file "/etc/apt/sources.list.d/brightbox-rubyee.list" do
    source "brightbox-rubyee.list"
    mode 0755
    owner "root"
    group "root"
    action :create
  end

  execute "add-key" do
    command "wget http://apt.brightbox.net/release.asc -O - | sudo apt-key add -"
    user "root"
    creates "/root/.add-key"
    action :run
  end

  execute "apt-get update" do
    command "apt-get update"
    user "root"
    action :run
  end
