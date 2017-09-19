FROM jlgrock/centos-oraclejdk:6.6-8u45
MAINTAINER Justin Grant <jlgrock@gmail.com>

ENV AMQ_PARENT /opt/app/jboss
ENV AMQ_HOME $AMQ_PARENT/jboss-a-mq

ADD install_files/ $AMQ_PARENT/
ADD resources/ $AMQ_PARENT/
ADD VERSION $AMQ_PARENT/VERSION
ADD loadenv.sh $AMQ_PARENT/loadenv.sh

WORKDIR $AMQ_PARENT

# Install amq
RUN ./install.sh

# move setup scripts to home directory
RUN mv init.sh $AMQ_HOME/init.sh && \
	mv setup_ssl.sh $AMQ_HOME/setup_ssl.sh && \
	mv activemq_ssl.xml $AMQ_HOME/activemq_ssl.xml

# Add script to start/stop instance
RUN mv $AMQ_PARENT/jboss-amq63 $AMQ_HOME/etc/jboss-amq63 && \
	mv $AMQ_PARENT/jboss-amq63.conf $AMQ_HOME/etc/jboss-amq63.conf && \
	mv $AMQ_PARENT/credentials-enc.properties $AMQ_HOME/etc/credentials-enc.properties

#Added security - not really necessary when there is only one user, but matches expect client systems
RUN chmod 700 $AMQ_HOME/etc/jboss-amq63.conf

### Create A-MQ User
RUN sed -i "s/#admin/admin/" $AMQ_HOME/etc/users.properties && \
	sed -i "s/#activemq.jmx.user/activemq.jmx.user/" $AMQ_HOME/etc/system.properties && \
	sed -i "s/#activemq.jmx.password/activemq.jmx.password/" $AMQ_HOME/etc/system.properties

### Open Ports
# SSH, Karaf-ssh, Web, rmiServerPort, rmiRegistry, ActiveMQ
EXPOSE 22 8101 8181 44444 1099 61616 

### Start A-MQ
ENTRYPOINT ["./jboss-a-mq/init.sh"]
CMD [""]
