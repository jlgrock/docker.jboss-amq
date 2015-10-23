#!/bin/bash

# Load the version from the VERSION file
for line in $(< VERSION)
do
  case $line in
    JBOSS_AMQ=*)  eval $line ;; # beware! eval!
    *) ;;
   esac
done

echo "Starting JBossA-MQ $..."
/opt/jboss/jboss-a-mq-$JBOSS_AMQ/bin/start
sleep 30
echo "JBoss A-MQ started"

tail -f /opt/jboss/jboss-a-mq-$JBOSS_AMQ/data/log/amq.log