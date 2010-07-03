define :crontab_file, :options => { } do
  options=params[:options]
  remote_file "/etc/cron.d/#{params[:name]}" do
    source "#{params[:name]}.crontab"
    owner "root"
    group "root"
    mode "0644"
    notifies :reload, resources(:service => "cron")
  end
end
