#!/bin/sh

# load the versions
. ./loadenv.sh

echo "Processing for A-MQ Version $JBOSS_AMQ, build $JBOSS_AMQ_BUILD"

if [ ! -e install_files/jboss-a-mq-$JBOSS_AMQ.$JBOSS_AMQ_BUILD.zip ]
then
	echo "could not find file install_files/jboss-a-mq-$JBOSS_AMQ.$JBOSS_AMQ_BUILD.zip"
	echo "You should put the required JBoss A-MQ binary into the root directory first."
	exit 255
fi

# Create containers
echo "Creating A-MQ Container ..."
docker build -q --rm -t jlgrock/jboss-amq:$JBOSS_AMQ .

if [ $? -eq 0 ]; then
    echo "Container Built"
else
    echo "Error: Unable to Build Container"
fi

