## Total memory available
total=`free -m | grep -i mem | tr -s ' '|cut -d " " -f2`

#mongod memory usage in mb
mongod_proc_mem=`top -b -n 1| grep -w mongod | tr -s ' ' |cut -d " " -f11`
mongod_mem_usage=`echo  $mongod_proc_mem*$total/100 |bc`

#redis memory usage in mb

redis_proc_mem=`top -b -n 1| grep -w redis | tr -s ' ' |cut -d " " -f11`
redis_val=`echo $redis_proc_mem*$total/100|bc`

# server.js memory usage in mb
server_js_mm=`top -bc n1| grep -w server.js | grep -v grep | tr -s ' ' |cut -d " " -f11`
uc_serverjs_usage=`echo $server_js_mm*$total/100 | bc`

#app.js memory usage in mb
app_js_mem=`top -bc n1| grep  -w app.js | grep -v grep | tr -s ' ' |cut -d " " -f11`
app_js_usage=`echo $app_js_mem*$total/100|bc`

# api_gateway -> index.js in mem  in mb
api_index_js_mem=`top -bc n1 | grep -w uc_api_gateway | grep -v grep | tr -s ' ' | cut -d " " -f11`
apiindex_js_usage=`echo $api_index_js_mem*$total/100 | bc`

# uc_push_notification -> index.js in mem mb
uc_push_index_js_mem=`top -bc n1 | grep -w index.js| egrep -v "uc_api|grep" | tr -s`
ucpush_indexjs_usage=`echo $uc_push_index_js_mem*$total/100|bc`

# uc_authentication_server --> server.js in mem mb
ucauth_service_js_mem=`top -bcn1 | grep uc_auth | egrep -v "grep|uc_server" | tr -s ' '| cut -d " " -f11
ucauth_serverjs_usage=`echo $ucauth_service_js_mem*$total/100|bc`

# nginx_worker
nginxworker_proc_mem=`top -bcn1 | egrep "worker process"| grep -v "grep" | tr -s ' '| cut -d " " -f10`
nginxworker_mem_usage=`echo $nginxworker_proc_mem*$total/100 |bc`

# nginx_master
nginxmaster_proc_mem=`top -bcn1 | egrep "master process" | grep -v grep | tr -s ' ' | cut -d " " -f10`
nginxmaster_mem_usage=`echo $nginxmaster_proc_mem*$total/100|bc`

# memorystats
echo "$total\t\t\t$mongod_mem_usage\t\t$redis_val\t\t\t$uc_serverjs_usage\t\t\t$app_js_usage\t\t\t$apiindex_js_usage\t\t\t$ucauth_serverjs_usage\t\t\t$nginxworker_mem_usage\t\t\t$nginxmaster_mem_usage"