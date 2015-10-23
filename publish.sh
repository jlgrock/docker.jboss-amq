#!/bin/sh

# Load the version from the VERSION file
for line in $(< VERSION)
do
  case $line in
    JBOSS_AMQ=*)  eval $line ;; # beware! eval!
    *) ;;
   esac
done

/bin/sh ./build.sh

# Build the image
docker push jlgrock/jboss-amq:$JBOSS_AMQ

if [ $? -eq 0 ]; then
    echo "Image Successfully Published with tag $JBOSS_A-MQ"
else
    echo "Error: Unable to Publish Image"
fi
