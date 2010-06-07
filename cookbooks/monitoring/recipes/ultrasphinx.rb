include_recipe 'monitoring'

node[:monit][:ultrasphinx].each do |appname|
  template "/etc/monit/conf.d/sphinx-#{appname}.monitrc" do
    source "ultrasphinx.erb"
    owner "root"
    group "root"
    mode 0644
    variables :appname => appname
    notifies :restart, resources(:service => "monit")
  end
end
