#!/bin/sh

# Load the current versions
echo "loading environment variables"
. ./loadenv.sh

AMQ_HOME=/opt/jboss/jboss-a-mq

### Install AMQ
echo "extracting AMQ"
unzip -q ./jboss-a-mq-$JBOSS_AMQ.$JBOSS_AMQ_BUILD.zip

echo "moving AMQ to home"
mv ./jboss-a-mq-$JBOSS_AMQ.$JBOSS_AMQ_BUILD $AMQ_HOME
