default[:passenger][:version]="2.2.14"
default[:passenger][:passengermaxrequests]="128"

mem=(memory[:total].gsub("kB","")).to_i
case
when (mem <= 329036)
  default[:passenger][:passengermaxpoolsize]="2"
when (mem <= 524508)
  default[:passenger][:passengermaxpoolsize]="6"
when (mem <= 1048796)
  default[:passenger][:passengermaxpoolsize]="14"
when (mem <= 2097372)
  default[:passenger][:passengermaxpoolsize]="30"
else
  default[:passenger][:passengermaxpoolsize]="62"
end




