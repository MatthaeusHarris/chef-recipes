set_unless[:passenger][:version]="2.2.7"
set_unless[:passenger][:passengermaxrequests]="128"
set_unless[:passenger][:brightbox][:passengerroot]="/usr/"
set_unless[:passenger][:brightbox][:passengerruby]="/usr/bin/ruby"
set_unless[:passenger][:brightbox][:gem_path] = "/usr/bin/gem"
set_unless[:passenger][:brightbox][:install_binary]=nil
set_unless[:passenger][:brightbox][:module] = "/usr/lib/apache2/modules/mod_passenger.so"
