candidate_nodes=search(:node,"network_interfaces_eth1:addresses")
nodes=Hash.new

candidate_nodes.each do |n|
  if n[:network][:interfaces][:eth1]
    n[:network][:interfaces][:eth1][:addresses].each do |address, params|
      if params[:family]=="inet"
        nodes[n[:fqdn]]=Hash.new
        nodes[n[:fqdn]].store(:hostname,n[:hostname])
        nodes[n[:fqdn]].store(:ip,address)
      end
    end
  end
end

template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(:nodes => nodes)
end

