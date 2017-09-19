#!/bin/bash

. $AMQ_HOME/setup_ssl.sh "$@"

echo "Starting JBoss A-MQ $JBOSS_AMQ"
$AMQ_HOME/bin/jboss-amq63 start

sleep 30
echo "JBoss A-MQ started"
tail -f $AMQ_HOME/data/log/amq.log
