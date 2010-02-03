define :railssite, :site_options => { } do

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
    server_name site_options[:server_name]
    server_aliases [ params[:name], node[:hostname] ] + site_options[:server_aliases]
    rails_env "production"
    ssl site_options[:type].to_s.scan("ssl").to_s
    certificatechainfile site_options[:certificatechainfile]
    includes site_options[:includes]
  end

  %w{config log pids system}.each do |dir|
    directory "/home/#{site_options[:user]}/app/shared/#{dir}" do
      recursive true
      owner site_options[:user]
      group site_options[:user]
      mode "0775"
      action :create
      not_if "test -d /home/#{site_options[:user]}/app/shared/#{dir}"
    end
  end

  script "set_permissions" do
    interpreter "bash"
    user "root"
    not_if do
      require 'etc'
      uid = File.stat("/home/#{site_options[:user]}/app").uid
      (Etc.getpwuid(uid).name).eql?(site_options[:user])
    end
    code <<-EOF
   chown -R #{site_options[:user]}:#{site_options[:user]} /home/#{site_options[:user]}/app/
   EOF
  end

  template "/home/#{site_options[:user]}/app/shared/config/database.yml" do
    source "database.yml.erb"
    owner site_options[:user]
    group site_options[:user]
    mode "0664"
    variables ( { :dbname => site_options[:dbname], :dbuser => site_options[:dbuser], :dbpasswd => site_options[:dbpasswd], :dbhost => site_options[:dbhost] } )
  end

  #  "create_database"
#  execute "create-database" do
#    command "mysqladmin -h #{site_options[:dbhost]} -u #{site_options[:dbuser]} -p#{site_options[:dbpasswd]} create #{site_options[:dbname]}"
#    creates "/var/tmp/#{site_options[:user]}-#{site_options[:dbname]}"
#  end

  file "/var/tmp/#{site_options[:user]}-#{site_options[:dbname]}" do
    action :create
  end
end
