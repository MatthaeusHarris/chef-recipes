define :staticsite, :site_options => { } do

  site_options=params[:site_options]

  file "/etc/apache2/passwords" do
    owner "root"
    group "root"
    mode "0644"
    only_if do site_options[:type].to_s.include?("staging") end
  end

  remote_file "/etc/apache2/conf.d/#{params[:name]}.conf" do
    source "#{params[:name]}/#{params[:name]}-includes.conf"
    owner "root"
    group "root"
    mode "0644"
    only_if do site_options[:includes] end
  end

  if site_options[:type].to_s.include?("ssl")

    include_recipe "apache2::mod_ssl"

    directory "/etc/apache2/ssl" do
      owner "root"
      group "root"
      mode "0755"
      action :create
      not_if "test -d /etc/apache2/ssl"
    end

    remote_file "/etc/apache2/ssl/server.crt" do
      source "server.crt"
      owner "root"
      group "root"
      mode "0644"
    end

    remote_file "/etc/apache2/ssl/server.key" do
      source "server.key"
      owner "root"
      group "root"
      mode "0644"
    end

    if site_options[:certificatechainfile]
      remote_file "/etc/apache2/ssl/caauthority.crt" do
        source "caauthority.crt"
        owner "root"
        group "root"
        mode "0644"
      end
    end
  end

  web_app params[:name] do
    docroot "/home/#{site_options[:user]}/app/current/public"
    template "#{site_options[:type]}.conf.erb"
    cookbook "railssites"
    rails_env "production"
    server_name site_options[:server_name]
    server_aliases [ params[:name], node[:hostname] ] + site_options[:server_aliases]
    ssl site_options[:type].to_s.scan("ssl").to_s
    certificatechainfile site_options[:certificatechainfile]
    includes site_options[:includes]
  end

  node[:railssites].each do |appname,params|
    remote_file "/etc/cron.d/#{appname}" do
      source "#{appname}.crontab"
      owner "root"
      group "root"
      mode "0644"
      notifies :reload, resources(:service => "cron")
      only_if do params[:crontab] end
    end
  end
end
