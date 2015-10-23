#!/bin/sh

# Load the version from the VERSION file
for line in $(< VERSION)
do
  case $line in
    JBOSS_AMQ=*)  eval "export $line" ;; # beware! eval!
	JBOSS_AMQ_BUILD=*)  eval "export $line" ;; # beware! eval!
    *) ;;
   esac
done