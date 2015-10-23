#!/bin/sh

# Load the version from the VERSION file
for line in $(< VERSION)
do
  case $line in
    JBOSS_AMQ=*)  eval $line ;; # beware! eval!
    *) ;;
   esac
done
echo "Processing for A-MQ Version $JBOSS_AMQ" 

if [ ! -e install_files/jboss-a-mq-$JBOSS_AMQ.zip ]
then
   echo "You should put the required JBoss A-MQ binary into the root directory first."
   exit 255
fi

# Create containers
echo "Creating A-MQ Container ..."
docker build -q --rm -t jlgrock/amq_JBOSS_AMQ .`

if [ $? -eq 0 ]; then
    echo "Container Built"
else
    echo "Error: Unable to Build Container"
fi

