#!/bin/sh
set -e

# Load the current versions
echo "loading environment variables"
. ./loadenv.sh

if [[ -z "${AMQ_HOME}" ]]; then
    echo "Need to set AMQ_HOME environment parameter"
    exit 1
fi

if [[ -z "${JBOSS_AMQ}" ]]; then
    echo "Need to set JBOSS_AMQ environment parameter"
    exit 1
fi

### Install AMQ
echo "extracting AMQ"
unzip -q ./amq-broker-${JBOSS_AMQ}-bin.zip

echo "owning dir"

echo "moving AMQ to home"
mv ./amq-broker-${JBOSS_AMQ} ${AMQ_HOME}
rm -f amq-broker-${JBOSS_AMQ}-bin.zip

chmod +x ${AMQ_HOME}/bin/artemis*
