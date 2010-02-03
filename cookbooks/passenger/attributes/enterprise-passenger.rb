set_unless[:passenger][:version]="2.2.7"
set_unless[:passenger][:passengermaxrequests]="128"
set_unless[:passenger][:enterprise][:passengerroot]= "#{ree[:path]}/lib/ruby/gems/1.8/gems/passenger-#{passenger[:version]}"
set_unless[:passenger][:enterprise][:passengerruby]= "#{ree[:path]}/bin/ruby"
set_unless[:passenger][:enterprise][:gem_path]= ree[:gem_path]
set_unless[:passenger][:enterprise][:install_binary]="#{ree[:path]}/bin/passenger-install-apache2-module"
set_unless[:passenger][:enterprise][:module]="#{passenger[:enterprise][:passengerroot]}/ext/apache2/mod_passenger.so"
