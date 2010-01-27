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




