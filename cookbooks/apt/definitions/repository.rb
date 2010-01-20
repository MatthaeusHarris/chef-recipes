define :repository do

  directory "/etc/apt/sources.list.d/" do
    action :create
    owner "root"
    group "root"
    mode "0755"
  end

  if params[:config_url] != nil
    remote_file "/etc/apt/sources.list.d/#{params[:name]}.list" do
      source params[:config_url]
      owner "root"
      group "root"
      mode "0644"
      action :create
    end
  else
    template "/etc/apt/sources.list.d/#{params[:name]}.list" do
      source "repository.erb"
      owner "root"
      group "root"
      mode "0644"
      action :create
      variables :repo_line => params[:repo_line]
    end
  end

  execute "add-key" do
    command "wget #{params[:key_url]} -O - | sudo apt-key add -"
    user "root"
    creates "/root/.add-key-#{params[:name]}"
    action :run
  end

  execute "apt-get update" do
    command "apt-get update"
    user "root"
    action :run
  end
end
