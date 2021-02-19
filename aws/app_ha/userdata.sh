#!/bin/bash
cat > /tmp/index.html <<EOF
<pre>
mysql['enable'] = false
mysql['host'] = ${mysql_host}
mysql['morpheus_db'] = '${mysql_morpheus_db}'
mysql['morpheus_db_user'] = '${mysql_morpheus_db_user}'
mysql['morpheus_password'] = '${mysql_morpheus_password}'
rabbitmq['enable'] = false
rabbitmq['vhost'] = '${rabbitmq_vhost}'
rabbitmq['queue_user'] = '${rabbitmq_queue_user}'
rabbitmq['queue_user_password'] = '${rabbitmq_queue_user_password}'
rabbitmq['host'] = '${rabbitmq_host}'
rabbitmq['port'] = '${rabbitmq_port}'
rabbitmq['heartbeat'] = ${rabbitmq_heartbeat}
elasticsearch['enable'] = false
elasticsearch['cluster'] = '${elastic_cluster}'
elasticsearch['es_hosts'] = ${elastic_es_hosts}
elasticsearch['use_tls'] = ${elastic_use_tls}
elasticsearch['auth_user'] = '${elastic_auth_user}'
elasticsearch['auth_password'] = '${elastic_auth_password}'

# AWS information
# current_vpc_id = ${vpc_current_vpc_id}
# default_vpc_id = ${vpc_default_vpc_id}
</pre>
EOF

nohup busybox httpd -h /tmp -p ${server_port}

cd /home/ubuntu
# apt-get update
curl --output ${morpheus_package} https://downloads.morpheusdata.com/files/${morpheus_package}
#apt-get install ./${morpheus_package}
#morpheus-ctl reconfigure
