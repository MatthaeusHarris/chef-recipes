mem=(memory[:total].gsub("kB","")).to_i

default[:passenger][:version]="2.2.7"
default[:passenger][:passengermaxrequests]="128"

case
when (memory <= 329036)
  default[:passenger][:passengermaxpoolsize]="2"
when (memory <= 524508)
  default[:passenger][:passengermaxpoolsize]="6"
when (memory <= 1048796)
  default[:passenger][:passengermaxpoolsize]="14"
when (memory <= 2097372)
  default[:passenger][:passengermaxpoolsize]="30"
else
  default[:passenger][:passengermaxpoolsize]="62"
end

if File.exists?(ree[:path]) && File.directory?(ree[:path])
  default[:passenger][:passengerroot]= "#{ree[:path]}/lib/ruby/gems/1.8/gems/passenger-#{passenger[:version]}"
  default[:passenger][:passengerruby]= "#{ree[:path]}/bin/ruby"
  default[:passenger][:gem_path] = ree[:gem_path]
  default[:passenger][:install_binary]="#{ree[:path]}/bin/passenger-install-apache2-module"
elsif platform.eql?("ubuntu") && platform_version.eql?("8.04") && languages[:ruby][:target_cpu].eql?("i486")
  default[:passenger][:passengerroot]="/usr/"
  default[:passenger][:passengerruby]="/usr/bin/ruby"
  default[:passenger][:gem_path] = "/usr/bin/gem"
  default[:passenger][:install_binary]=nil
else
  default[:passenger][:passengerroot]="/usr/lib/ruby/gems/1.8/passenger-#{passenger[:version]}"
  default[:passenger][:passengerruby]="/usr/bin/ruby"
  default[:passenger][:gem_path] = "/usr/bin/gem"
  default[:passenger][:install_binary]="/usr/bin/passenger-install-apache2-module"
end



