packages= %w{ apache2-prefork-dev libapr1-dev libaprutil1-dev }

packages.each do |p|
  package p do
    action :install
    action :upgrade
  end
end
