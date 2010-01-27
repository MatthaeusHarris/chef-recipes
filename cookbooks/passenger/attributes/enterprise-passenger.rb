  default[:passenger][:enterprise][:passengerroot]= "#{ree[:path]}/lib/ruby/gems/1.8/gems/passenger-#{passenger[:version]}"
  default[:passenger][:enterprise][:passengerruby]= "#{ree[:path]}/bin/ruby"
  default[:passenger][:enterprise][:gem_path]= ree[:gem_path]
  default[:passenger][:enterprise][:install_binary]="#{ree[:path]}/bin/passenger-install-apache2-module"
  default[:passenger][:enterprise][:module]="#{passenger[:enterprise][:passengerroot]}/ext/apache2/mod_passenger.so"
