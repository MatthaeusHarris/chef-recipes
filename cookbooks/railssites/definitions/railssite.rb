
define :railssite, :site_options => {} do

  site_options=params[:site_options]

  t = (site_options[:ssl] ? "app-ssl.conf.erb" : "app.conf.erb")

  web_app params[:name] do
    docroot "/home/#{site_options[:user]}/app/current/public"
    template t
    server_name site_options[:server_name]
    server_aliases [ params[:name], node[:hostname] ]
    rails_env "production"
    ssl site_options[:ssl]
    certificatechainfile site_options[:certificatechainfile]
  end

  %w{config log pids system}.each do |dir|
    directory "/home/#{site_options[:user]}/app/shared/#{dir}" do
      recursive true
      owner site_options[:user]
      group site_options[:user]
      mode "0775"
      action :create
    end
  end


  script "set_permissions" do
    interpreter "bash"
    user "root"
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

#  include_recipe "railssites::crontabs" if site_options[:crontabs]

end
