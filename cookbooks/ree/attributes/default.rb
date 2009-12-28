set[:ree][:version] = "ruby-enterprise-1.8.7-2009.10"
set[:ree][:url] = "http://rubyforge.org/frs/download.php/66162/#{ree[:version]}.tar.gz"
set[:ree][:tar_file] = "#{ree[:src_path]}/#{ree[:version]}.tar.gz"
set[:ree][:src_path] = "/opt/src"
set[:ree][:path] = "/opt/#{ree[:version]}"
set[:ree][:gem_path] = "#{ree[:path]}/bin/gem"

