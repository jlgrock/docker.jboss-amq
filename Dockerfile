FROM jlgrock/centos-oraclejdk:6.6-8u45
MAINTAINER Justin Grant <jlgrock@gmail.com>

### Set Environment
ENV AMQ_HOME /opt/jboss/jboss-a-mq-$AMQ_VERSION
ENV AMQ_VERSION=6.2.0.GA

### Install AMQ
ADD install_files/jboss-a-mq-$AMQ_VERSION.zip /tmp/jboss-a-mq-$AMQ_VERSION.zip
RUN unzip /tmp/jboss-a-mq-$AMQ_VERSION.zip
ADD docker_init.sh /opt/jboss/jboss-a-mq-$AMQ_VERSION/docker_init.sh

### Set Permissions
RUN chown -R jboss:jboss $AMQ_HOME && \
	chmod 755 $AMQ_HOME/docker_init.sh
USER jboss

### Create A-MQ User
RUN sed -i "s/#admin/admin/" $AMQ_HOME/etc/users.properties && \
	sed -i "s/#activemq.jmx.user/activemq.jmx.user/" $AMQ_HOME/etc/system.properties && \
	sed -i "s/#activemq.jmx.password/activemq.jmx.password/" $AMQ_HOME/etc/system.properties

### Open Ports
# SSH, Karaf-ssh, Web, rmiServerPort, rmiRegistry, ActiveMQ
EXPOSE 22 8101 8181 44444 1099 61616 

### Start A-MQ
ENTRYPOINT $AMQ_HOME/docker_init.sh