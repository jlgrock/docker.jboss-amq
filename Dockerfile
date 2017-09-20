FROM jlgrock/centos-oraclejdk:6.6-8u144
MAINTAINER Justin Grant <jlgrock@gmail.com>

ENV AMQ_PARENT /opt/app/jboss
ENV AMQ_HOME $AMQ_PARENT/jboss-a-mq

ADD install_files/ $AMQ_PARENT/
ADD resources/ $AMQ_PARENT/
ADD VERSION $AMQ_PARENT/VERSION
ADD loadenv.sh $AMQ_PARENT/loadenv.sh

# Come back to this - we should be running this under a specific user
# RUN useradd -s /bin/bash -U JbossAdm 
# USER JbossAdm

WORKDIR $AMQ_PARENT

# Install amq
RUN ./install.sh

# move setup scripts to home directory
RUN mv init.sh $AMQ_HOME/ && \
	mv setup_ssl.sh $AMQ_HOME/ && \
	mv activemq_ssl.xml $AMQ_HOME/

# Add script to start/stop instance
RUN mv $AMQ_PARENT/jboss-amq63 $AMQ_HOME/bin/ && \
	mv $AMQ_PARENT/jboss-amq63.conf $AMQ_HOME/bin/

# set user accounts and custom config
RUN mv $AMQ_PARENT/credentials-enc.properties $AMQ_HOME/etc/ && \
	mv $AMQ_PARENT/users.properties $AMQ_HOME/etc/

### Create A-MQ User - to get an encrypted password, use jasypt
RUN sed -i "s/#encryption.enabled = false/encryption.enabled = true/" $AMQ_HOME/etc/org.apache.karaf.jaas.cfg && \
	sed -i "s/#encryption.algorithm = MD5/encryption.algorithm = SHA-256/" $AMQ_HOME/etc/org.apache.karaf.jaas.cfg && \
	sed -i "s/#activemq.jmx.user/activemq.jmx.user/" $AMQ_HOME/etc/system.properties && \
	sed -i "s/#activemq.jmx.password/activemq.jmx.password/" $AMQ_HOME/etc/system.properties

#Added security - not really necessary when there is only one user, but matches expect client systems
RUN chmod 700 $AMQ_HOME/bin/jboss-amq63.conf

### Open Ports
# SSH, Karaf-ssh, Web, rmiServerPort, rmiRegistry, ActiveMQ
EXPOSE 22 8101 8181 44444 1099 61616 

### Start A-MQ
ENTRYPOINT ["./jboss-a-mq/init.sh"]
CMD [""]
