mem=(memory[:total].gsub("kB","")).to_i

case
when (mem <= 329036)
  default[:monit][:apache][:memory]= "170 MB"
when (mem <= 524508)
  default[:monit][:apache][:memory]= "340 MB"
when (mem <= 1048796)
  default[:monit][:apache][:memory]= "680 MB"
when (mem <= 2097372)
  default[:monit][:apache][:memory]= "1360 MB"
else
  default[:monit][:apache][:memory]= "2720 MB"
end
