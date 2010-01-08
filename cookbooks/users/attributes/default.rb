# -*- coding: utf-8 -*-


# passwords must be in shadow password format with a salt. To generate: openssl passwd -1
# you have to specify keys as an array

set[:users][:frodo] = {:password => "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", :comment => "Frodo Baggins", :group  => :admin}
set[:ssh_keys][:frodo]  = [ "ssh-rsa XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" ]


