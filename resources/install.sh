#!/bin/sh
set -e

# Load the current versions
echo "loading environment variables"
. ./loadenv.sh

if [ -z "$AMQ_HOME" ]; then
    echo "Need to set AMQ_HOME"
    exit 1
fi

if [ -z "$JBOSS_AMQ" ]; then
    echo "Need to set JBOSS_AMQ"
    exit 1
fi

if [ -z "$JBOSS_AMQ_BUILD" ]; then
    echo "Need to set JBOSS_AMQ_BUILD"
    exit 1
fi

### Install AMQ
echo "extracting AMQ"
unzip -q ./jboss-a-mq-$JBOSS_AMQ.$JBOSS_AMQ_BUILD.zip

echo "owning dir"

echo "moving AMQ to home"
mv ./jboss-a-mq-$JBOSS_AMQ.$JBOSS_AMQ_BUILD $AMQ_HOME

rm -f jboss-a-mq-$JBOSS_AMQ.$JBOSS_AMQ_BUILD.zip
