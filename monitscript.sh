#!/bin/bash
#Total Memory
echo "TIME      Redis Mongod UC_SERVER UC_AE_SERVER UC_AUTH_SERVICE UC_PUSH_NOTIFIER UC_API_GATEWAY   NGINXWORKER     NGINXMASTER" >> procsmemusage.csv
total=`free -m | grep -i mem | tr -s ' '|cut -d " " -f2`
while :
do
#sleep 1
#1 monitor redis memory usage
redis_proc_mem=`top -b -n 1| grep -w redis | tr -s ' ' |cut -d " " -f11`
redis_usage=`echo $redis_proc_mem*$total/100|bc`

#2 Monitor mongod memory usage
mongod_proc_mem=`top -b -n 1| grep -w mongod | tr -s ' ' |cut -d " " -f11`
mongod_usage=`echo  $mongod_proc_mem*$total/100 |bc`

#3 Monitor uc_server -> server.js memory usage
uc_server_js_mm=`top -bc n1| grep uc_server | grep -v grep | tr -s ' ' |cut -d " " -f11`
uc_serverjs_usage=`echo $uc_server_js_mm*$total/100 | bc`

#4 Monitor uc_ae_server -> app.js memory usage
uc_ae_app_js_mem=`top -bc n1| grep  uc_ae_server | grep -v grep | tr -s ' ' |cut -d " " -f11`
ucapp_js_usage=`echo $uc_ae_app_js_mem*$total/100|bc`

#5 Monitory uc_authentication_server --> server.js memory usage
ucauth_service_js_mem=`top -bcn1 | grep uc_auth | egrep -v "grep|uc_server" | tr -s ' '| cut -d " " -f11`
ucauth_serverjs_usage=`echo $ucauth_service_js_mem*$total/100|bc`

#6 Monitory uc_push_notification_manager -> index.js
uc_push_index_js_mem=`top -bc n1| grep  uc_push | grep -v grep | tr -s ' ' |cut -d " " -f11`
ucpush_indexjs_usage=`echo $uc_push_index_js_mem*$total/100|bc`

#7 Monitory uc_api_gateway -> index.js memory usage
uc_api_index_js_mem=`top -bc n1 | grep  uc_api_gateway | grep -v grep | tr -s ' ' | cut -d " " -f11`
uc_apindexjs_usage=`echo $uc_api_index_js_mem*$total/100 | bc`

#8 nginx worker process memory usage
nginxworker_proc_mem=`top -bcn1 | egrep "worker process"| grep -v "grep" | tr -s ' '| cut -d " " -f10`
nginxwork_usage=`echo $nginxworker_proc_mem*$total/100 |bc`

#9 nginx master process
nginxmaster_proc_mem=`top -bcn1 | egrep "master process" | grep -v grep | tr -s ' ' | cut -d " " -f10`
nginxmaster_usage=`echo $nginxmaster_proc_mem*$total/100|bc`

#Memory stats
echo -e "$(date +%T)  $redis_usage\t$mongod_usage\t$uc_serverjs_usage\t\t$ucapp_js_usage\t\t$ucauth_serverjs_usage\t\t$ucpush_indexjs_usage\t\t$uc_apindexjs_usage\t\t$nginxwork_usage\t\t$nginxmaster_usage" >> procsmemusage.csv
done
