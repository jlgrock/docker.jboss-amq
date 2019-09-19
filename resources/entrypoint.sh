#!/bin/bash
set -x -e

# Define Functions
. setup_connection.sh

# Set Default Variables
if [[ -z "${BROKER_NAME}" ]]; then
    export BROKER_NAME='amq'
fi

if [[ -z "${CLIENT_USERNAME}" ]]; then
    export CLIENT_USERNAME='amq'
fi

if [[ -z "${CLIENT_PASSWORD}" ]]; then
    export CLIENT_PASSWORD='amq123!'
fi

if [[ -z "${SSH}" ]]; then
    export SSH='false'
fi

# Create Broker
echo "Creating JBoss A-MQ broker"
${AMQ_HOME}/bin/artemis create --user ${CLIENT_USERNAME} --password ${CLIENT_PASSWORD} --http-host $(hostname -I) --require-login --force ${BROKER_NAME}

## Edit access so that we don't have cross site scripting issues.  Please note that this opens it up to the world.
xmlstarlet ed \
    --inplace \
    -s "/restrict/cors" \
        -t elem -n 'allow-origin' \
        -v '*://0.0.0.0*' \
    -d "/restrict/cors/strict-checking" \
        ${AMQ_PARENT}/${BROKER_NAME}/etc/jolokia-access.xml


# Setup the Broker
setup_connection

# Start the broker and output the logs
echo "Starting JBoss A-MQ $JBOSS_AMQ"
${AMQ_HOME}/../${BROKER_NAME}/bin/artemis-service start

sleep 5
echo "JBoss A-MQ started"
tail -f ${AMQ_HOME}/../${BROKER_NAME}/log/artemis.log
