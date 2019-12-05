#!/bin/bash

# extract assets
unzip /home/vcap/app/BOOT-INF/classes/static/pcfshell_debugger_buildpack_offline.zip -d /home/vcap/app/BOOT-INF/classes/static 

# update haproxy shell protector password
if [ ! -z $debugger_password ];
  then
    sed -i "s/.*password.*/ user pcfuser insecure-password $debugger_password/" /home/vcap/app/BOOT-INF/classes/static/bin/deps/haproxy.config
fi

# launch shellinaboxd wrapped with haproxy providing basic-auth
if [ -n "$debugger_password" ]; then echo debugger_password=$debugger_password; else echo debugger_password_not_set; fi && /home/vcap/app/BOOT-INF/classes/static/bin/deps/haproxy -f /home/vcap/app/BOOT-INF/classes/static/bin/deps/haproxy.config & /home/vcap/app/BOOT-INF/classes/static/bin/deps/shellinaboxd -t -v -p 18081 --css /home/vcap/app/BOOT-INF/classes/static/bin/deps/white-on-black.css  -s /:${USER}:${USER}:${PWD}:"CF_INSTANCE_ADDR=${CF_INSTANCE_ADDR} CF_INSTANCE_CERT=${CF_INSTANCE_CERT} CF_INSTANCE_GUID=${CF_INSTANCE_GUID} CF_INSTANCE_INDEX=${CF_INSTANCE_INDEX} CF_INSTANCE_INTERNAL_IP=${CF_INSTANCE_INTERNAL_IP} CF_INSTANCE_IP=${CF_INSTANCE_IP} CF_INSTANCE_KEY=${CF_INSTANCE_KEY} CF_INSTANCE_PORT=${CF_INSTANCE_PORT} CF_INSTANCE_PORTS=${CF_INSTANCE_PORTS} CF_SYSTEM_CERT_PATH=${CF_SYSTEM_CERT_PATH} HOSTNAME=${HOSTNAME} INSTANCE_GUID=${INSTANCE_GUID} INSTANCE_INDEX=${INSTANCE_INDEX} VCAP_APPLICATION='${VCAP_APPLICATION}' VCAP_APP_HOST=${VCAP_APP_HOST} VCAP_APP_PORT=${VCAP_APP_PORT} VCAP_PLATFORM_OPTIONS=${VCAP_PLATFORM_OPTIONS} VCAP_SERVICES='${VCAP_SERVICES} debugger_password=${debugger_password}' bash"
