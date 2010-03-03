include_recipe 'monitoring'

node[:monit][:sphinx].each do |appname|
  template "/etc/monit/conf.d/sphinx-#{appname}.monitrc" do
    source "sphinx.erb"
    owner "root"
    group "root"
    mode 0644
    variables ( :appname => appname )
    notifies :restart, resources(:service => "monit")
  end
end
