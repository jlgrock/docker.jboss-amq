#!/bin/sh

###############################################################
# This script will build the core version of the AMQ instance,
# storing the image to jlgrock/jboss-eap
###############################################################

# load the versions
. ./loadenv.sh

IMAGE_NAME=jlgrock/jboss-amq
IMAGE_VERSION="${JBOSS_AMQ_BUILD}"

echo "Processing for A-MQ Version $JBOSS_AMQ, build $JBOSS_AMQ_BUILD"

if [ ! -e install_files/amq-broker-${JBOSS_AMQ}-bin.zip ]
then
	echo "could not find file install_files/jboss-a-mq-${JBOSS_AMQ}.zip"
	echo "You should put the required JBoss A-MQ binary into the root directory first."
	exit 255
fi

# Create containers
echo "Creating A-MQ Container ..."
docker build -q --rm -t ${IMAGE_NAME}:${JBOSS_AMQ} .

if [ $? -eq 0 ]; then
    echo "Container Built"
else
    echo "Error: Unable to Build Container"
fi

