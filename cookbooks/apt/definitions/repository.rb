define :repository do

include_recipe "apt"

  directory "/etc/apt/sources.list.d/" do
    action :create
    owner "root"
    group "root"
    mode "0755"
  end

  remote_file "/etc/apt/sources.list.d/#{params[:name]}.list" do
    params[:config_url] ? (source params[:config_url]) : (source params[:name])
    owner "root"
    group "root"
    mode "0644"
    action :create
  end

  execute "add-key" do
    command "wget #{params[:key_url]} -O - | sudo apt-key add -"
    user "root"
    creates "/var/tmp/.add-key-#{params[:name]}"
    action :run
    notifies :run, resources(:execute => "apt-get update")
  end

  file "/var/tmp/.add-key-#{params[:name]}"
end
