if File.exists?(ree[:path]) && File.directory?(ree[:path]) # If rubyee is installed with britghtbox repository gem_binary is the same than with standard ruby
  default[:gems][:binary]=ree[:gem_path]
else
  default[:gems][:binary]="/usr/bin/gem"
end
