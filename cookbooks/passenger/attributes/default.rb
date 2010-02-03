set_unless[:passenger][:version]="2.2.7"
set_unless[:passenger][:passengermaxrequests]="128"

mem=(memory[:total].gsub("kB","")).to_i
case
when (mem <= 329036)
  set_unless[:passenger][:passengermaxpoolsize]="2"
when (mem <= 524508)
  set_unless[:passenger][:passengermaxpoolsize]="6"
when (mem <= 1048796)
  set_unless[:passenger][:passengermaxpoolsize]="14"
when (mem <= 2097372)
  set_unless[:passenger][:passengermaxpoolsize]="30"
else
  set_unless[:passenger][:passengermaxpoolsize]="62"
end




