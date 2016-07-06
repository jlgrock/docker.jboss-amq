#!/bin/bash

ssl=false
ssl_host="0.0.0.0"
ssl_port=61616
JASYPT_ENCRYPTION_PASSWORD="encryptPassword"

while [[ -n $1 ]]; do
    case $1 in
    --ssl)          ssl=true ;;
    --ssl-host)     shift
                    ssl_host="$1"
                    ;;
    --ssl-port)     shift
                    ssl_port="$1"
                    ;;
    --encrypt-pass) shift
                    JASYPT_ENCRYPTION_PASSWORD="$1"
                    ;;
    *) ;;
    
    esac
    shift
done

create_amq_properties() {
	if ! ls /amq/store/broker/broker.ks \
        /amq/store/pw/keystore_pw \
        /amq/store/broker/broker.ts \
        /amq/store/pw/keystore_pw \
        &> /dev/null; then
      
		cat <<- ERROR
		Missing required key files:
		- /amq/store/broker/broker.ks
		- /amq/store/pw/keystore_pw
		- /amq/store/broker/broker.ts
		- /amq/store/pw/keystore_pw 
		ERROR
        
        exit 1
    fi
    
    amq_properties=$AMQ_HOME/etc/amq.properties
    echo "keystore.file=/amq/store/broker/broker.ks" >> $amq_properties
    echo "keystore.password=ENC($(cat /amq/store/pw/keystore_pw))" >> $amq_properties
    echo "truststore.file=/amq/store/broker/broker.ts" >> $amq_properties
    echo "truststore.password=ENC($(cat /amq/store/pw/keystore_pw))" >> $amq_properties
    echo "ssl.host=$ssl_host" >> $amq_properties
    echo "ssl.port=$ssl_port" >> $amq_properties
}

if [ "$ssl" = true ]; then
    echo "Configuring SSL"
    create_amq_properties
    mv -f $AMQ_HOME/activemq_ssl.xml $AMQ_HOME/etc/activemq.xml
    export JASYPT_ENCRYPTION_PASSWORD
fi
