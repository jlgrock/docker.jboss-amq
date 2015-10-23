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

sed -ie "s/ENV AMQ_VERSION=FILL_IN_VERSION/ENV AMQ_VERSION=$JBOSS_AMQ/" ./Dockerfile
sed -ie "s/ENV AMQ_BUILD=FILL_IN_VERSION/ENV AMQ_BUILD=$JBOSS_AMQ_BUILD/" ./Dockerfile

# Create containers
echo "Creating A-MQ Container ..."
docker build -q --rm -t jlgrock/amq_jboss_amq .

if [ $? -eq 0 ]; then
    echo "Container Built"
else
    echo "Error: Unable to Build Container"
fi

