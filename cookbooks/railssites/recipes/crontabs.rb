# Commented code below is not working so we are using crontabs as files for now,
# I will fix them in the near future

# node[:crontabs].each do |app,cronjobs|
#   pp cronjobs
#   cronjobs.each do |cronjob, params|
#     params.each do |param,value|
#      #  cron app do
#       #    param value
#       #  end
#     end
#   end
# end

node[:railssites].each do |appname,params|
  remote_file "/etc/cron.d/#{appname}" do
    source "#{appname}.crontab"
    owner "root"
    group "root"
    mode "0644"
    notifies :reload, resources(:service => "cron")
    only_if do params[:crontabs] end
  end
end

