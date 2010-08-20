if File.exists?(ree[:path]) && File.directory?(ree[:path]) # If rubyee is installed with britghtbox repository gem_binary is the same than with standard ruby
  set[:gems][:binary]=ree[:gem_path]
else
  set[:gems][:binary]="/usr/bin/gem"
end

case platform_version
when "8.04"
  dependencies=%w(libmagick9-dev libmysqlclient15-dev)
when "10.04"
  dependencies=%w(libmagickcore-dev libmysqlclient-dev)
end

default[:gems][:dependencies]=%w(libxslt1-dev libxml2 libxml2-dev imagemagick libfreeimage-dev) + dependencies
default[:gems][:packages]=%w(mysql bundler newrelic_rpm)

