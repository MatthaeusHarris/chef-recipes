if File.exists?(ree[:path]) && File.directory?(ree[:path]) # If rubyee is installed with britghtbox repository gem_binary is the same than with standard ruby
  set[:gems][:binary]=ree[:gem_path]
else
  set[:gems][:binary]="/usr/bin/gem"
end
