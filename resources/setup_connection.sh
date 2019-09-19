#!/bin/bash

setup_connection() {
    ORIGINAL_CONNECTION_STR='tcp://0.0.0.0:61616?tcpSendBufferSize=1048576;tcpReceiveBufferSize=1048576;protocols=CORE,AMQP,STOMP,HORNETQ,MQTT,OPENWIRE;useEpoll=true;amqpCredits=1000;amqpLowCredits=300;'
    CONNECTION_STR="${ORIGINAL_CONNECTION_STR}"

    if [ "${SSL,,}" = "true" ]; then
       if ! ls /amq/store/broker/broker.ks \
            /amq/store/broker/broker.ts \
            &> /dev/null; then
      
                cat << ERROR
Missing required keystore/truststore files:
- /amq/store/broker/broker.ks
- /amq/store/broker/broker.ts
ERROR
            
            exit 1
        fi

        echo "Enabling SSL"
        if [ -z "${KEYSTORE_PASSWORD}" ]; then
            echo "if SSL is defined, KEYSTORE_PASSWORD must be set as well"
            
            exit 1
        fi
        if [ -z "${TRUSTSTORE_PASSWORD}" ]; then
            echo "if SSL is defined, TRUSTSTORE_PASSWORD must be set as well"
            
            exit 1
        fi

        CONNECTION_STR="sslEnabled=true;"
        CONNECTION_STR="${CONNECTION_STR}keyStorePath=/amq/store/broker/broker.ks;"
        CONNECTION_STR="${CONNECTION_STR}keystore.password=ENC($(${AMQ_PARENT}/bin/${BROKER_NAME}/bin/artemis mask ${KEYSTORE_PASSWORD});"
        CONNECTION_STR="${CONNECTION_STR}keyStorePath=/amq/store/broker/broker.ts;"
        CONNECTION_STR="${CONNECTION_STR}truststore.password=ENC($(${AMQ_PARENT}/bin/${BROKER_NAME}/bin/artemis mask ${TRUSTSTORE_PASSWORD})"

    fi
    
    # Replace the connection string
    sed ':a;N;$!ba; s|<acceptor name=\"artemis\">.*<\/acceptor>|<acceptor name=\"artemis\">'"${CONNECTION_STR}"'<\/acceptor>|g' ${AMQ_PARENT}/${BROKER_NAME}/etc/broker.xml
}
