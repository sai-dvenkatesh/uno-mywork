#!/bin/bash -x
server=$(ifconfig enp0s3 | grep 192.* | awk '{print $2}')
i=$(pm2 list | grep -i uc_server | cut -d "│" -f8)
for (( a=1;a<=3;a++ ))
do
        if [ $i == `pm2 list | grep -i uc_server | cut -d "│" -f8` ]
        then
        status=`sucess`
               continue
      else
        status=`failed`
echo "pm2 failed" |mail -s "pm2 restart is $status in  $server: "  sai.dvenkatesh@gmail.com
grep "date +%H:%M"  `pm2 show 6 | grep error | cut -d "│" -f3`
        fi

done
