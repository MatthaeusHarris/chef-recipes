packages = %w{ build-essential zlib1g libssl-dev libreadline5-dev libmysqlclient15-dev libsqlite3-dev }

packages.each do |p|
  package p do
    action :install
    action :upgrade
  end
end
