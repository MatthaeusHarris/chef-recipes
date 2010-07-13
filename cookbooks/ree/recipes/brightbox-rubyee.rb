include_recipe 'apt::brightbox-rubyee'

packages=%w(libruby1.8 irb1.8 libopenssl-ruby1.8 libreadline-ruby1.8 rdoc1.8 ruby1.8)

packages.each do |p|
  package p do
    action :upgrade
  end
end


