#!/bin/sh

# load the versions
. ./loadenv.sh

# Build the image
. ./build.sh

# Publish the image
docker push jlgrock/jboss-amq:$JBOSS_AMQ

if [ $? -eq 0 ]; then
    echo "Image Successfully Published with tag $JBOSS_A-MQ"
else
    echo "Error: Unable to Publish Image"
fi
