#!/bin/bash

# load the versions
. ./loadenv.sh

echo "Starting JBossA-MQ $..."
/opt/jboss/jboss-a-mq-$JBOSS_AMQ/bin/start
sleep 30
echo "JBoss A-MQ started"

tail -f /opt/jboss/jboss-a-mq-$JBOSS_AMQ/data/log/amq.log