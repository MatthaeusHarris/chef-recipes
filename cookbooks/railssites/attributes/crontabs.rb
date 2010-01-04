# set[:crontabs][:mailto]="ballsbreaking@bebanjo.com"
# set[:crontabs][:path]="/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
# set[:crontabs][:shell]="/bin/sh"

# set[:crontabs][:sequence][:ts] = { 
#   :minute => "@reboot", :hour => "", :day => "", :month => "", :weekday => "", 
#   :command => "cd /var/www/apps/tsa/current && RAILS_ENV=production rails ts:in ts:start" 
# }
# 
# set[:crontabs][:sequence][:delayed_job] = { 
#   :minute => "@reboot", :hour => "", :day => "", :month => "", :weekday => "",
#   :command => "cd /var/www/apps/tsa/current && RAILS_ENV=production script/job_runner start 0; RAILS_ENV=production script/job_runner start 1" 
# }



#  :sphinx_indexer => {  }

