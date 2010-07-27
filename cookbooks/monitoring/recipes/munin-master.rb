package "munin" do
  action :install
end

g=gem_package "domainatrix" do
  action :nothing
end
g.run_action(:install)
require 'rubygems'
Gem.clear_paths
require 'domainatrix'

nodes=search(:node, "network_interfaces_eth1:addresses")
domains={ }

nodes.each do |n|
  url=Domainatrix.parse("http://#{n[:fqdn]}")
  if domains[url.domain+"."+url.public_suffix]==nil
    domains[url.domain+"."+url.public_suffix]=[n]
  else
    domains[url.domain+"."+url.public_suffix] << n
  end
end

template "/etc/munin/munin.conf" do
  source "munin-master.conf.erb"
  mode "0644"
  owner "root"
  group "root"
  variables(:nodes => nodes, :domains => domains)
end



